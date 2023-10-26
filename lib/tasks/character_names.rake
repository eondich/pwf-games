require 'csv'

namespace :character_names do
  desc "Set up character name data"

  task :import, [:file_name] => :environment do |t, args|
    if args.file_name
      begin
        seen_ancestries = {}

        CSV.foreach(args.file_name, headers: true) do |row|
          value = row["value"]
          
          ancestry_str = row["ancestry"]&.downcase
          ancestry = if seen_ancestries[ancestry_str]
            seen_ancestries[ancestry_str]
          else
            # Log an error if needed
            ancestry_obj = Ancestry.find_by(name: ancestry_str)
            seen_ancestries[ancestry_str] = ancestry_obj
            ancestry_obj
          end

          gender_str = row["gender"]&.downcase
          gender = if gender_str == "f" || gender_str == "female"
            CharacterName.genders[:female]
          elsif gender_str == "m" || gender_str == "male"
            CharacterName.genders[:male]
          else
            nil
          end

          type_str = row["type"]&.downcase
          type = type_str ? CharacterName.name_types[type_str.to_sym] : nil

          # Don't duplicate a record, but allow for the same name to have multiple
          # ancestries, genders, and types (Tiffany could be a surname or a first name
          # used by humans, elves, and halflings, for example)
          if ancestry
            unless CharacterName.where(value: value).where(gender: gender).where(name_type: type).joins(:ancestries).where(:ancestries=> {:id => [ancestry.id]}).exists?
              CharacterName.create(value: value, ancestries: [ancestry], gender: gender, name_type: type)
            end
          else
            CharacterName.where(value: value).where(gender: gender).where(name_type: type).each do |n|
              unless Ancestry.joins(:character_names).where(:character_names => {id: [n.id]})
                break
              end
            end
            CharacterName.create(value: value, gender: gender, name_type: type)
          end
        end
      rescue StandardError => e
        raise e
      end
    else
      puts "Please include file name in arguments"
      puts "Usage: rake \"character_names:import[filename]\""
    end
  end
end
