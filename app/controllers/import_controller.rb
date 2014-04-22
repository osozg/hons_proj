class ImportController < ApplicationController

  def main
    begin
      require 'csv'
      place = 1 + (Theorem.maximum(:place) || 0)
      CSV.foreach(params[:filepath], :headers => true) do |row|
        new_theorem = {place: place}
        new_theorem[:name] = row.to_hash['match']
        new_theorem[:is_item] = row.to_hash['item?']=='1'
        new_theorem[:place] = place
        if new_theorem[:is_item]
          new_theorem[:theorem_ids] = []
          theorem_names = row.to_hash['attributes'].split(',').uniq
          theorem_names.each do |tn|
            th = Theorem.find_by_name(tn)
            new_theorem[:theorem_ids] << th.id if th
          end
        end
        old_theorem = Theorem.find_by_name(new_theorem[:name])
        if old_theorem
          old_theorem.update_attributes(new_theorem)
        else
          Theorem.create(new_theorem)
          place += 1
        end
      end
      redirect_to root_path, notice: 'Import was successful'
    rescue
      redirect_to root_path, notice: 'Import failed'
    end
  end

  def clear
    Positive.delete_all
    Theorem.delete_all
    redirect_to root_path
  end

end