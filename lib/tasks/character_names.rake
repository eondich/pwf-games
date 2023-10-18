namespace :character_names do
  desc "Set up character name data"
  task import: :environment do
    # This is how you'd create a new source.  I already created the PHB for testing
    # so just grabbing it instead
    # example_source = SourceMaterial.create(name: "PHB")
    example_source = SourceMaterial.find_by(name: "PHB")
    # You can find all the data I've set up as the default in db/seeds.rb.  I'm
    # planning to add some source materials to that file as well, we can talk
    # about that as you start working on this project and presumably need them
    # for names.  Should we have a game system table, too?  So like put the PHB
    # and Xanathar's or whatever in source materials and 5e in systems?
    # Also you can see the db setup in db/schema.rb
    anc_human = Ancestry.find_by(name: "human")
    anc_elf = Ancestry.find_by(name: "elf")
    # Here's the array of possible name types.  Use the index as the value for
    # name_type.  This data is also in models/character_name.rb
    # [:given_name, :family_name, :nickname, :clan_name]
    # Same deal with genders, but female is 0, male is 1, leave out for
    # agender/ambiguous
    # Example name entries!  Obviously not in the PHB, don't actually run this
    CharacterName.create(value: "Willa", name_type: 0, gender: 0, source_materials: [example_source], ancestries: [anc_human, anc_elf])
    CharacterName.create(value: "Oz", name_type: 2, gender: 1, source_materials: [example_source], ancestries: [anc_human])
  end
end
