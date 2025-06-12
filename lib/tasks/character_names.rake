require 'csv'

namespace :character_names do
  desc "Set up character name data"

  task :import, [:file_name] => :environment do |t, args|
    if args.file_name
      begin
        seen_ancestries = {}
        seen_styles = {}

        CSV.foreach('./names.csv', headers: true) do |row|
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

          style_str = row["style"]&.downcase
          style = if seen_styles[style_str]
            seen_styles[style_str]
          else
            style_obj = NameStyle.find_by(style: style_str)
            seen_styles[style_str] = style_obj
            style_obj
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

          game_system_name = row["system"]&.downcase
          game_system = GameSystem.find_by(name: game_system_name)

          # Don't duplicate a record, but allow for the same name to have multiple
          # ancestries, genders, and types (Tiffany could be a surname or a first name
          # used by humans, elves, and halflings, for example)
          existing_name = CharacterName.where(value: value).where(gender: gender).where(name_type: type).first
          name = existing_name || CharacterName.create(value: value, gender: gender, name_type: type)

          # Add ancestry, if needed
          if ancestry && name.ancestries.exclude?(ancestry)
            name.ancestries << ancestry
          end

          # Add name style, if needed
          if style && name.name_styles.exclude?(style)
            name.name_styles << style
          end

          # Add game system, if needed
          if name.game_systems.exclude?(game_system)
            name.game_systems << game_system
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
