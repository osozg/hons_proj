class RecommendController < ApplicationController

  def main
    theorems = params[:tns].split(',').map{|tn| Theorem.find_by_name(tn.strip)}
    theorem_ids = theorems.reject(&:nil?).map(&:id)
    positives = Positive.where(theorem_id: theorem_ids)
    item_ids = positives.map(&:item_id).uniq
    item_sims = item_ids.inject({}){|accum, ii| accum.merge!(ii => 0)}
    positives.each{|positive| item_sims[positive.item_id] += 1}
    @item_sims = item_sims.sort_by{|_key, value| value}.reverse

    top_items = @item_sims[0..2].map{|ii,sim| Theorem.find(ii)}
    top_simls = @item_sims[0..2].map{|ii,sim| sim}
    pot_posts = top_items.map(&:theorem_ids)
    rel_posts = pot_posts.flatten.uniq.reject{|p| theorem_ids.include? p}
    estims = {}
    rel_posts.each do |ti|
      estim = 0
      (0..2).each do |n|
        if pot_posts[n].include? ti
          estim += top_simls[n]
        end
      end
      estims[ti] = estim.to_f / top_simls.sum
    end
    @estims = estims.sort_by{|_key, value| value}.reverse
  end

end