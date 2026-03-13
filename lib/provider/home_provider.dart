import 'package:fff_skin_tools/model/home_item_model.dart';
import 'package:flutter/foundation.dart';
import '../constants/app_icons.dart';

class HomeProvider with ChangeNotifier {
  final List<HomeItemModel> _items = [
    HomeItemModel(
      title: "Elite Characters",
      subTitle: "Discover the most powerful characters and their abilities",
      image: AppIcons.dimondCharacters,
    ),
    HomeItemModel(
      title: "Battle Pets",
      subTitle: "Explore all pets and choose the best companion for battle",
      image: AppIcons.pets,
    ),
    HomeItemModel(
      title: "Legendary Bundles",
      subTitle: "Unlock rare bundles and exclusive outfits",
      image: AppIcons.bundles,
    ),
    HomeItemModel(
      title: "Pro Weapons",
      subTitle: "Learn about the best weapons and their power",
      image: AppIcons.weapons,
    ),
    HomeItemModel(
      title: "Battle Vehicles",
      subTitle: "Know every vehicle and when to use it",
      image: AppIcons.vehicles,
    ),
    HomeItemModel(
      title: "Diamond Guide",
      subTitle: "Tips and tricks to earn and use diamonds wisely",
      image: AppIcons.diamondBox,
    ),
  ];
  List<HomeItemModel> get items => _items;

  final List<HomeItemModel> _characters = [
    HomeItemModel(
      title: "A-PATROA",
      subTitle: "",
      description: ""
          "A-Patroa character extra special skill slot can be equipped "
          "with any skill on the account and is automatically unlocked upon getting the character.\n\n"
          ""
          "The Ross (Anitta) is a strong and confident woman who has a music store and sensory "
          "experiences in a dangerous neighborhood.\n\n"
          "In addition, her store serves as a safe space for anyone seeking help. "
          "The experiences offered by the store are not only a form of fun, "
          "but also a way to help people.\n\n"
          "Patroa owns a music store that serves not only as a space for socializing and "
          "entertainment in a particularly dangerous region, but also as a shelter for people "
          "in vulnerable situations, especially women. The space allows these women to explore "
          "and experience freedom and security, free from judgment.\n\n"
          "In the store, it is possible to enjoy an experience technologically created by her "
          "that allows them to fully immerse themselves in emotions, memories and experiences. "
          "The experience is called RIO, as is the store.",
      image: AppIcons.aPatroa,
    ),
    HomeItemModel(
      title: "DIMITRI",
      subTitle: "",
      description:
          "Dimitri is the elder brother of Thiva. In his daily life, he would spend most "
          "of his day at the lab developing new sound technology. After he found his passion for music, "
          "he realized that helping the world and improving people's lives moving forward through his "
          "technological creations might be one of his dreams.\n\n"
          "DIMITRI  CHARACTERS INFORMATION:\n\n"
          "Dimitri is one of the recommended characters for players who prefer healing skills. "
          "He has an active skill called Healing Heartbeat. The skill allows its users to create "
          "3.5m healing zones. Players who are inside the zone can recover 3HP/sec. If a player or "
          "teammate is down, they can self recover to get up. At its initial level, the skill lasts "
          "for 20 seconds and has an 85-second cooldown. Players can upgrade their character level by "
          "using EXP cards and playing more ranked matches. It will help them unlock further upgrade "
          "levels of the character with improved skills.\n\n"
          "Level 2: Duration increases by 11 seconds and cooldown reduces to 80 seconds.\n"
          "Level 3: Duration increases by 12 seconds and the cooldown reduces to 75 seconds.\n"
          "Level 4: Duration increases by 13 seconds and the cooldown reduces to 70 seconds.\n"
          "Level 5: Duration increases by 14 seconds and the cooldown reduces to 65 seconds.\n"
          "Level 6: Duration increases by 15 seconds and the cooldown reduces to 60 seconds.",
      image: AppIcons.dimitri,
    ),
    HomeItemModel(
      title: "HOMER",
      subTitle: "",
      description:
          "Homer possesses the unique ability named 'Senses Shockwave.' "
          "Upon activation of the skill on the battlefield, it releases a drone towards "
          "the nearest enemy within a 100m frontal distance, creating a 5m-diameter pulse "
          "explosion which reduces movement speed by 10% and firing rate by 10%.\n\n"
          "HOMER  CHARACTERS INFORMATION:\n\n"
          "Homer is a blind man who is also an assassin. He is the founder of the Griza gang. "
          "The character comes with a special survival ability, known as Sense Shockwave. "
          "With this, Homer is able to release a drone to the nearest frontal enemy, creating "
          "a 5m-diameter pulse explosion, which reduces enemy movement speed and firing speed. "
          "He can release the drone at the closest frontal enemy, creating a 5 meter diameter "
          "pulse burst that reduces the enemy's movement speed and firing speed and deals 25 damage "
          "to them. The duration of the slow effect is 5 seconds. The drone's search area is 100 meters "
          "in front, which is quite large.\n\n"
          "Homer's ability in FF is an active skill and can only be used for combos with other passive skills. "
          "Overall, since the duration of the drone effect is quite short (5 seconds), it is most effective "
          "in rusher combos.",
      image: AppIcons.ffHomer,
    ),
    HomeItemModel(
      title: "IRIS",
      subTitle: "",
      description:
          "The Iris character in the game is an expert at Walls of Ice and has a powerful "
          "capacity to brand and exterminate foes on the battlefield, so your enemies must be terrified.\n\n"
          "IRIS  CHARACTERS INFORMATION:\n\n"
          "Iris has two crucial skill aspects, namely the ability to mark enemies and penetrate the Gloo Wall. "
          "Once the skill is active, players only need to shoot the Gloo Wall to activate the enemy marker "
          "located behind the Gloo Wall. The skill of Iris is able to attack the marked enemy behind the Gloo Wall. "
          "Iris' skill can penetrate 5 Gloo Walls even in a parallel position. So even enemies behind 5 Gloo Walls "
          "can still be attacked by Iris. At the maximum level, the cooldown of the skill is only 55 seconds, "
          "making Iris strong enough to even counter Skyler and Chrono.",
      image: AppIcons.ffIris,
    ),
    HomeItemModel(
      title: "J. BIEBS",
      subTitle: "",
      description:
          "J.Biebs has a special survival skill called Night Silence, helping players to "
          "overcome their opponents on the battlefield. At its lowest level, Silence of Night allows "
          "users and their allies within 6 meters to block incoming damage using their EP.\n\n"
          "J.BIEBS  CHARACTERS INFORMATION:\n\n"
          "J.Biebs is a man who wants to unite a fractured world. Through his childhood experiences, "
          "he learned that the answer to people's problems is not money or power, but the actual "
          "connection between people. He then decided to use his singing skills to dedicate his life "
          "to reunite the world.\n\n"
          "Silent Sentinel allows users and their allies to block damage using EP, and the amount of "
          "EP deducted from allies will be added to the user's EP. The range of this ability is 6 meters "
          "at the lowest level, while the damage percentage prevented is 7%.",
      image: AppIcons.jBeibs,
    ),
    HomeItemModel(
      title: "KENTA",
      subTitle: "",
      description:
          "Kenta character can create a front shield that can withstand all enemy attacks "
          "from the front. He can now protect his teammates.\n\n"
          "KENTA  CHARACTERS INFORMATION:\n\n"
          "Kenta does not have a unique ability, but can be equipped with an existing ability. "
          "Kenta is a recommended character for beginners, they can equip and experiment.\n\n"
          "• Use against explosives: Kenta's ability proves very effective against grenades, "
          "launchers, and others. Using his shield power, players can tackle any combat including explosives.\n"
          "• Purely defensive: The area of the force field is quite large, so it protects teammates very effectively.\n"
          "• The time to use Swordsman's Wrath is also quite long. However, it automatically disappears when Kenta takes any shot.\n"
          "• No one can attack through a force field: Swordsman's Wrath blocks about half of enemy "
          "weapons damage, rendering nearly every attack ineffective.",
      image: AppIcons.kenta,
    ),
    HomeItemModel(
      title: "LUNA",
      subTitle: "",
      description:
          "Luna's Fight-or-Flight ability is of great use to players who use weapons with "
          "slower fire rates. With a quicker fire rate, players can empty their magazine much faster "
          "and deal more damage to their enemies. The character's ability helps players enhance the "
          "weapon fire rate and increase movement speed, which helps in swift movement and better "
          "aim tracing in FF MAX.\n\n"
          "LUNA  CHARACTERS INFORMATION:\n\n"
          "Luna comes under the passive character list and is not bound by any time duration. The "
          "character is inspired by the popular Thai actress 'Yaya Urassaya.' Luna features a special "
          "passive ability called Fight-or-Flight.\n\n"
          "With the help of this ability:\n"
          "• Players can improve the firing rate of the weapon.\n"
          "• Movement speed also increases.\n\n"
          "Players can use the character with weapons that have great damage per hit but lack a fire rate. "
          "The character is suitable for assault rifles and shotguns with heavy damage, and with Luna, "
          "the rate of fire will be enhanced. The character will be available in the character store "
          "after the in-game event ends.",
      image: AppIcons.luna,
    ),
    HomeItemModel(
      title: "LEON",
      subTitle: "",
      description:
          "Leon is a university student and comes with extreme basketball skills. "
          "The character comes with Buzzer Beater survival ability that allows players to recover HP "
          "after engagement in combat.\n\n"
          "LEON  CHARACTERS INFORMATION:\n\n"
          "With Leon's ability being a passive skill, you can combine it with pretty much all skills "
          "in the game, from long to close range. It is very effective against chip damage - a combination "
          "of Buzzer Beater and EP could get you to full HP quickly.\n\n"
          "Overall, Assaulter and Sniper builds are the best for Leon, as you can get 100 -> 0 rather quick "
          "in close range fights. Leon is another character that has been added to FF, and has a unique ability "
          "named Buzzer Beater. He recovers HP after surviving a combat encounter, and this can turn out to be "
          "helpful during aggressive gameplay.\n\n"
          "HP Recovery Levels:\n"
          "• Level 1: 5 HP\n"
          "• Level 2: 10 HP\n"
          "• Level 3: 15 HP\n"
          "• Level 4: 20 HP\n"
          "• Level 5: 25 HP\n"
          "• Level 6: 30 HP",
      image: AppIcons.leon,
    ),
    HomeItemModel(
      title: "NAIRI",
      subTitle: "",
      description:
          "Nairi's Ice Iron ability automatically heals the Gloo Walls after they have been deployed. "
          "At level 1 of the ability, the Gloo Walls recover 20% of their durability every 20 seconds.\n\n"
          "NAIRI  CHARACTERS INFORMATION:\n\n"
          "In Free Fire, Nairi's ability gets activated automatically. He has a special survival ability "
          "where the deployed Gloo Walls will recover a certain amount of current durability every 1 second "
          "when they take damage.\n\n"
          "Additionally, the user equipping this skill will deal increased damage on Gloo Walls when using "
          "any AR weapons, making Nairi both a defensive and offensive character.",
      image: AppIcons.nairi,
    ),
    HomeItemModel(
      title: "OTHO",
      subTitle: "",
      description:
          "Otho is not a collaboration or classic character but has been introduced through the "
          "Free Fire E-comics. He is a memory tech engineer from Polytech University.\n\n"
          "OTHO  CHARACTERS INFORMATION:\n\n"
          "Otho is not yet available in the in-game store. Currently, players can unlock him only "
          "through the ongoing top-up event. By topping up a certain amount of diamonds, players "
          "can get Otho for free, and optionally, they can also acquire the Otho character bundle.\n\n"
          "Otho’s special ability is called *Memory Mist*. When users eliminate enemies, Otho can reveal "
          "the locations of other foes within a 25-meter radius. This information can also be shared with "
          "teammates, giving a tactical advantage. As the player levels up, the ability’s range increases, "
          "reaching a maximum of 50 meters at higher levels.",
      image: AppIcons.otho,
    ),
    HomeItemModel(
      title: "THIVA",
      subTitle: "",
      description:
          "At its initial level, Thiva’s rescue speed is increased by 10%, and on a successful rescue, "
          "the player recovers 15 HP in 5 seconds. At max level, the rescue speed increases by 25%, and after "
          "rescuing, the player recovers 40 HP in 5 seconds.\n\n"
          "THIVA  CHARACTERS INFORMATION:\n\n"
          "Thiva is the little brother of Dimitri. He was innately talented and played music throughout his childhood. "
          "He truly wants to help the world and improve people's lives, believing the best way to do that is to reach "
          "the individual with a true message through his music.\n\n"
          "His special ability is called *Vital Vibes*, which improves the help-up speed by 5% at the first level. "
          "Additionally, players who are revived receive 15 health points in the next five seconds. The ability significantly "
          "improves as the level rises. At the maximum level of 6, users’ help-up speed is buffed to 20%, while the HP "
          "recovered after rescue reaches 40.",
      image: AppIcons.thiva,
    ),
    HomeItemModel(
      title: "TATSUYA",
      subTitle: "",
      description:
          "Tatsuya is known for his speed, being the fastest among the playable characters in the game. "
          "He is equipped with an active ability known as 'Rebel Rush', which helps him move forward at rapid speed. "
          "This skill can also be accumulated for consecutive use.\n\n"
          "TATSUYA  CHARACTERS INFORMATION:\n\n"
          "Tatsuya's ability is active, meaning it must be manually activated and can be used for a limited duration. "
          "He can move forward at a rapid speed for 0.5 seconds. The skill can be accumulated for consecutive uses "
          "(up to 2 times). Since it is an active skill, it has a cooldown of 40 seconds. Additionally, consecutive uses "
          "add 5 extra seconds of cooldown.\n\n"
          "Players can upgrade Tatsuya's skill using memory fragments, which will eventually reduce the cooldown to 30 seconds, "
          "making him extremely effective for quick retreats or aggressive plays.",
      image: AppIcons.tatsuya,
    ),
  ];

  List<HomeItemModel> get characters => _characters;
  final List<HomeItemModel> _pets = [
    HomeItemModel(
      title: "AGENT HOP",
      subTitle: "",
      description:
          "Agent Hop is one of the most useful pets in Free Fire for long matches and end zones. "
          "His ability, 'Bunny Boost,' allows him to generate EP automatically whenever the safe zone shrinks. "
          "This means that players will never run out of EP in long-lasting matches. "
          "Since EP gradually converts into HP, Agent Hop can provide a continuous healing effect without "
          "the need to rely solely on medkits. At higher levels, this EP gain is significant enough to "
          "keep you alive in the shrinking zones or when caught outside the play area.",
      image: AppIcons.agentHop,
    ),
    HomeItemModel(
      title: "DETECTIVE PANDA",
      subTitle: "",
      description:
          "Detective Panda is perfect for aggressive players who love rushing and taking down enemies. "
          "His ability, 'Panda’s Blessings,' restores HP whenever you eliminate an enemy. "
          "At the base level, it restores 4 HP per kill, but when maxed out, it restores up to 10 HP per kill. "
          "This makes it an incredible pet for sustained fights, where you don’t have time to heal. "
          "Detective Panda essentially turns every kill into a mini healing boost, "
          "keeping you healthy and ready for the next battle.",
      image: AppIcons.detectivePanda,
    ),
    HomeItemModel(
      title: "DREKI",
      subTitle: "",
      description:
          "Dreki is a dragon pet with the unique ability 'Dragon Glare.' "
          "This skill allows Dreki to detect opponents within a certain radius when they are using medkits. "
          "At max level, Dreki can detect up to 4 enemies within 30 meters for 5 seconds. "
          "This is a powerful ability for rushers, as it reveals hiding enemies who are trying to heal during fights. "
          "Knowing exactly where your injured enemies are gives you the perfect chance to finish them off "
          "before they can recover.",
      image: AppIcons.dreki,
    ),
    HomeItemModel(
      title: "FANG",
      subTitle: "",
      description:
          "Fang is another healing pet similar to Detective Panda, but his skill is slightly more versatile. "
          "Every time the player eliminates an opponent, Fang restores a certain amount of HP. "
          "At max level, this healing is quite significant, giving players an edge in continuous combat situations. "
          "Fang is highly recommended for players who prefer to fight aggressively, as the healing helps them "
          "recover instantly and continue engaging without needing to use medkits frequently.",
      image: AppIcons.fang,
    ),
    HomeItemModel(
      title: "BEASTON",
      subTitle: "",
      description:
          "Beaston is one of the best pets for players who heavily use grenades, gloo walls, flashbangs, "
          "and smoke grenades. His skill increases the throwing distance of all throwable items. "
          "At max level, the throwing distance increases by 30%. "
          "This means you can surprise enemies by throwing grenades further than they expect "
          "or deploy gloo walls at a distance for quick protection. "
          "Beaston is extremely effective in squad battles and ranked matches where utility items are essential.",
      image: AppIcons.beaston,
    ),
    HomeItemModel(
      title: "DR. BEANIE",
      subTitle: "",
      description:
          "Dr. Beanie is an excellent pet for stealth and rotation strategies. "
          "His skill increases your movement speed while crouching. "
          "At base level, crouch speed is increased by 30%, and at max level, it goes up to 60%. "
          "This makes it easier for players to sneak around silently while moving quickly. "
          "Dr. Beanie is perfect for players who like to stay hidden, rotate through cover, or avoid being spotted "
          "by enemies while still maintaining mobility.",
      image: AppIcons.drBeanie,
    ),
    HomeItemModel(
      title: "FALCO",
      subTitle: "",
      description:
          "Falco is the ultimate pet for squads and fast-paced gameplay. "
          "His ability improves gliding and skydiving speeds after jumping from the plane. "
          "At max level, gliding speed increases by 45% and diving speed by 50%. "
          "This allows you and your teammates to land much faster, loot weapons earlier, "
          "and be battle-ready before the opponents even touch the ground. "
          "Falco’s skill applies to the entire squad, making him a must-have in team matches.",
      image: AppIcons.falco,
    ),
    HomeItemModel(
      title: "FINN",
      subTitle: "",
      description:
          "Finn is a supportive pet that shines during critical squad battles. "
          "His skill boosts the movement speed of the player and teammates "
          "whenever a teammate is knocked down or eliminated. "
          "At max level, this boost is significant, allowing players to either retreat quickly or counterattack swiftly. "
          "Finn is a clutch pet that provides momentum during tough fights and can turn the tide of battle.",
      image: AppIcons.finn,
    ),
    HomeItemModel(
      title: "FLASH",
      subTitle: "",
      description:
          "Flash provides resistance against explosive damage, making it especially useful in lobbies "
          "where grenades, launchers, and mines are common. "
          "At max level, Flash reduces explosive damage taken by 30%. "
          "This pet is a lifesaver against grenade spammers and explosive-heavy enemies, "
          "ensuring that you can survive much longer in chaotic battles.",
      image: AppIcons.flash,
    ),
    HomeItemModel(
      title: "HOOT",
      subTitle: "",
      description: "Hoot is a pet designed for intelligence and tracking. "
          "His ability increases the duration of scanning effects from skills like Moco’s hacker eye, UAVs, "
          "and other enemy-detection features. "
          "At max level, it extends scan duration by 50%, allowing you to track enemies longer "
          "and plan better strategies to counter them. "
          "Hoot is a great partner for scouts and players who prioritize information in battle.",
      image: AppIcons.hoot,
    ),
    HomeItemModel(
      title: "MOONY",
      subTitle: "",
      description:
          "Moony is a defensive pet that reduces incoming damage while the player is using medkits, repair kits, "
          "or healing guns. "
          "At max level, Moony reduces damage taken by 35% while healing or repairing. "
          "This makes him an excellent pet for players who often heal in the middle of fights or need to repair vests "
          "and helmets while under fire. Moony ensures that you can heal safely and survive longer.",
      image: AppIcons.moony,
    ),
    HomeItemModel(
      title: "NIGHT PANTHER",
      subTitle: "",
      description:
          "Night Panther increases the inventory capacity of the player, "
          "allowing them to carry more ammunition, grenades, and other items. "
          "At max level, the inventory capacity increases by 45, which is a huge advantage in long matches. "
          "This pet is particularly useful for players who love to carry multiple weapons and lots of utility items "
          "without worrying about running out of space.",
      image: AppIcons.nightPanther,
    ),
    HomeItemModel(
      title: "ROBO",
      subTitle: "",
      description:
          "Robo strengthens gloo walls by adding an additional HP shield to them. "
          "At max level, Robo adds 100 HP to each gloo wall deployed. "
          "This makes gloo walls much harder to break, providing extra protection for the player and their squad. "
          "Robo is extremely effective for defensive players and those who rely heavily on gloo walls for cover.",
      image: AppIcons.robo,
    ),
    HomeItemModel(
      title: "MR. WAGGOR",
      subTitle: "",
      description:
          "Mr. Waggor is one of the most popular and useful pets in Free Fire. "
          "His ability allows him to produce a free gloo wall every 100–120 seconds if the player has none. "
          "At max level, he generates them even faster. "
          "This makes him a must-have for solo players and squads who run out of gloo walls during intense battles. "
          "Mr. Waggor ensures that you always have a shield available, making him invaluable in competitive gameplay.",
      image: AppIcons.mrWaggor,
    ),
    HomeItemModel(
      title: "OTTERO",
      subTitle: "",
      description: "Ottero is a healing pet with the ability 'Double Blubber.' "
          "Whenever a player uses a medkit or treatment gun, Ottero restores EP equivalent to a percentage of the HP healed. "
          "At max level, he restores 65% of the recovered HP as EP. "
          "This provides a continuous source of EP, which can then regenerate into HP over time. "
          "Ottero is excellent for players who want consistent healing and sustainability in matches.",
      image: AppIcons.ottero,
    ),
    HomeItemModel(
      title: "ROCKIE",
      subTitle: "",
      description:
          "Rockie is a pet that reduces the cooldown of active skills, "
          "making it incredibly useful for characters like Alok, Skyler, Xayne, or Chrono. "
          "At max level, Rockie reduces the cooldown of active skills by 15%. "
          "This means players can use their abilities more frequently, giving them a significant advantage in battles. "
          "Rockie is the perfect pet for ability-based strategies.",
      image: AppIcons.rockie,
    ),
    HomeItemModel(
      title: "SENSAI TIG",
      subTitle: "",
      description:
          "Sensei Tig is a counter-pet that reduces the duration of enemy skills. "
          "At max level, it reduces the effect duration by 50%. "
          "This makes it extremely effective against strong enemy abilities, "
          "as it cuts their duration in half and prevents them from gaining full benefit. "
          "Sensei Tig is ideal for competitive players who want to neutralize enemy skills quickly.",
      image: AppIcons.sensaiTig,
    ),
    HomeItemModel(
      title: "SPIRIT FOX",
      subTitle: "",
      description:
          "Spirit Fox is a healing pet that provides additional HP when using medkits. "
          "At max level, it grants 10 extra HP per medkit used. "
          "This can make a big difference in tough battles, where every bit of HP counts. "
          "Spirit Fox is great for defensive and survival-based players who focus on healing and endurance.",
      image: AppIcons.spiritFox,
    ),
    HomeItemModel(
      title: "ZASIL",
      subTitle: "",
      description: "Zasil is a support pet with a unique ability. "
          "When the player uses a medkit, inhaler, or repair kit, Zasil automatically gives a random consumable, "
          "such as a medkit, repair kit, or inhaler. "
          "At max level, this has a cooldown of 70 seconds. "
          "Zasil is perfect for long-lasting matches and survival gameplay, as it provides free items at regular intervals.",
      image: AppIcons.zasil,
    ),
    HomeItemModel(
      title: "SHIBA",
      subTitle: "",
      description:
          "Shiba is a tracking pet with the ability to mark mushrooms on the map every 120 seconds. "
          "This helps players collect mushrooms to fill their EP bar faster. "
          "At higher levels, the marking becomes more frequent and accurate. "
          "Shiba is a great pet for survival mode players who rely on EP for continuous healing.",
      image: AppIcons.shiba,
    ),
    HomeItemModel(
      title: "YETI",
      subTitle: "",
      description:
          "Yeti is a defensive pet designed to reduce explosive damage. "
          "His ability decreases incoming damage from grenades and launchers. "
          "At max level, Yeti reduces explosive damage by 30%. "
          "This makes him extremely valuable in matches where opponents rely heavily on grenades "
          "or launcher weapons to wipe out squads hiding behind cover.",
      image: AppIcons.yeti,
    ),
  ];

  List<HomeItemModel> get pets => _pets;

  final List<HomeItemModel> _bundles = [
    HomeItemModel(
      title: "BREAKDANCER BUNDLE",
      subTitle: "",
      description:
          "The BreakDancer Bundle is a stylish outfit inspired by street dance culture. With flashy colors, urban vibes, and funky moves, this bundle makes you stand out on the battlefield. Perfect for players who love energy, rhythm, and showing off their swagger in Free Fire.",
      image: AppIcons.breakDancer,
    ),
    HomeItemModel(
      title: "BUNNY WARRIOR BUNDLE",
      subTitle: "",
      description:
          "The Bunny Warrior Bundle combines cuteness with fierceness. This warrior outfit is designed with bunny ears and a unique battle armor theme, making it both adorable and deadly. It’s perfect for players who want to bring a mix of fun and power to the battlefield.",
      image: AppIcons.bunnyWarrior,
    ),
    HomeItemModel(
      title: "GOLDEN SAKURA BUNDLE",
      subTitle: "",
      description:
          "The Golden Sakura Bundle is an elegant outfit inspired by Japanese cherry blossoms. Dressed in golden tones with floral highlights, this bundle symbolizes honor, tradition, and strength. A premium choice for players who love style and sophistication in Free Fire.",
      image: AppIcons.goldenSakura,
    ),
    HomeItemModel(
      title: "GREEN CRIMINAL BUNDLE",
      subTitle: "",
      description:
          "The Green Criminal Bundle is one of the most iconic and rarest outfits in Free Fire. Known for its vibrant green mask and unique criminal-style jumpsuit, it is highly desired by collectors. Wearing this bundle makes you instantly recognizable on the battlefield.",
      image: AppIcons.greenCriminal,
    ),
    HomeItemModel(
      title: "HIP HOP BUNDLE",
      subTitle: "",
      description:
          "The Hip Hop Bundle is one of the most legendary bundles in Free Fire. Featuring baggy outfits, street-style caps, and a true old-school vibe, this bundle is a symbol of OG players. It reflects freedom, rhythm, and dominance in the game’s history.",
      image: AppIcons.hipHop,
    ),
    HomeItemModel(
      title: "KING SWORD BUNDLE",
      subTitle: "",
      description:
          "The King Sword Bundle represents royalty and power. Dressed like a warrior king with armor and sword-themed details, this outfit showcases dominance and leadership. Players who equip this bundle are seen as fearless rulers of the battlefield.",
      image: AppIcons.kingSward,
    ),
    HomeItemModel(
      title: "NIGHT CLOWN BUNDLE",
      subTitle: "",
      description:
          "The Night Clown Bundle is creepy yet stylish. With a terrifying clown mask and dark-themed attire, it is designed to strike fear into enemies. A favorite among players who love a spooky presence with an unpredictable edge in Free Fire.",
      image: AppIcons.nightClown,
    ),
    HomeItemModel(
      title: "RED CRIMINAL BUNDLE",
      subTitle: "",
      description:
          "The Red Criminal Bundle is one of the rarest and most famous bundles in Free Fire history. With its striking red mask and iconic jumpsuit, it has become a legendary status symbol. Owning this bundle means you are part of the elite veterans of Free Fire.",
      image: AppIcons.redCriminal,
    ),
    HomeItemModel(
      title: "SAMURAI BUNDLE0",
      subTitle: "",
      description:
          "The Samurai Bundle is inspired by ancient Japanese warriors. With traditional armor, masks, and sharp detailing, this outfit gives players the look of a fearless fighter. It symbolizes honor, discipline, and unmatched strength in Free Fire battles.",
      image: AppIcons.samurai,
    ),
  ];

  List<HomeItemModel> get bundles => _bundles;

  //// Weapons

  final List<HomeItemModel> _weapons = [
    HomeItemModel(
      title: "AK47",
      subTitle: "",
      description:
          "The AK47 is one of the most powerful assault rifles in Free Fire. Known for its massive damage and high headshot potential, it is deadly in skilled hands. However, it comes with high recoil, requiring good control and accuracy.",
      image: AppIcons.ak47,
    ),
    HomeItemModel(
      title: "AN94",
      subTitle: "",
      description:
          "The AN94 is a balanced assault rifle that delivers stable firing and solid damage. It is known for its unique burst-fire mode, allowing players to unleash accurate shots with controlled recoil.",
      image: AppIcons.an94,
    ),
    HomeItemModel(
      title: "AWM",
      subTitle: "",
      description:
          "The AWM is the king of snipers in Free Fire. With its unmatched range and one-shot kill potential to the head, this weapon dominates long-distance combat. Rare to find, but extremely powerful in the right hands.",
      image: AppIcons.awm,
    ),
    HomeItemModel(
      title: "GATLING",
      subTitle: "",
      description:
          "The Gatling Gun is a heavy weapon with an enormous magazine size. It delivers continuous firepower, making it perfect for suppressing enemies. Its weight and slower movement are balanced by devastating damage output.",
      image: AppIcons.gatling,
    ),
    HomeItemModel(
      title: "GROZA",
      subTitle: "",
      description:
          "The Groza is a rare and versatile assault rifle with excellent damage, stability, and range. Considered one of the best ARs in Free Fire, it is mostly found in airdrops, making it highly desirable.",
      image: AppIcons.groza,
    ),
    HomeItemModel(
      title: "M4A1",
      subTitle: "",
      description:
          "The M4A1 is a reliable all-rounder assault rifle. With balanced damage, range, and accuracy, it is favored by beginners and pros alike. It performs well in both close and long-range fights.",
      image: AppIcons.m4a1,
    ),
    HomeItemModel(
      title: "M24",
      subTitle: "",
      description:
          "The M24 sniper rifle offers high damage with slightly faster firing speed than the AWM. It is effective for long-range combat and is easier to handle, making it a deadly alternative sniper.",
      image: AppIcons.m24,
    ),
    HomeItemModel(
      title: "M60",
      subTitle: "",
      description:
          "The M60 is a light machine gun that shines in continuous fire. With its large magazine, it is ideal for squad fights and suppressing enemies. The weapon’s recoil can be challenging to control.",
      image: AppIcons.m60,
    ),
    HomeItemModel(
      title: "M82B",
      subTitle: "",
      description:
          "The M82B is a powerful sniper rifle with armor-penetrating bullets. It can deal damage through Gloo Walls and vehicles, making it a unique and game-changing long-range weapon.",
      image: AppIcons.m82,
    ),
    HomeItemModel(
      title: "M249",
      subTitle: "",
      description:
          "The M249 is a heavy machine gun found in airdrops. With its massive magazine and high damage per shot, it is excellent for crowd control and long spray battles.",
      image: AppIcons.m249,
    ),
    HomeItemModel(
      title: "M1014",
      subTitle: "",
      description:
          "The M1014 is a pump-action shotgun designed for close-range combat. It deals devastating damage at close quarters, capable of taking down enemies with a single shot.",
      image: AppIcons.m1014,
    ),
    HomeItemModel(
      title: "M1887",
      subTitle: "",
      description:
          "The M1887 is the most feared shotgun in Free Fire. With its high armor penetration and massive damage, it can destroy enemies in just one or two shots at close range. A fan-favorite among rush players.",
      image: AppIcons.m1887,
    ),
    HomeItemModel(
      title: "MP5",
      subTitle: "",
      description:
          "The MP5 is a submachine gun with great stability and high firing speed. It is reliable in close combat and favored by players who prefer consistent sprays with good control.",
      image: AppIcons.mp5,
    ),
    HomeItemModel(
      title: "MP40",
      subTitle: "",
      description:
          "The MP40 is the fastest-firing SMG in Free Fire. Known as the king of rush gameplay, it shreds opponents in close-range battles with incredible speed, though it has a small magazine size.",
      image: AppIcons.mp40,
    ),
    HomeItemModel(
      title: "SCAR",
      subTitle: "",
      description:
          "The SCAR is one of the most balanced assault rifles in Free Fire. With low recoil, decent fire rate, and good accuracy, it is a popular choice for beginners and experienced players alike.",
      image: AppIcons.scar,
    ),
    HomeItemModel(
      title: "SKS",
      subTitle: "",
      description:
          "The SKS is a semi-automatic sniper rifle that allows quick follow-up shots. It offers strong damage and accuracy, making it deadly for medium to long-range engagements.",
      image: AppIcons.sks,
    ),
    HomeItemModel(
      title: "SVD",
      subTitle: "",
      description:
          "The SVD (Dragunov) is a rare sniper rifle with high damage and armor penetration. Found mostly in airdrops, it is excellent for punishing armored enemies at long distances.",
      image: AppIcons.svd,
    ),
    HomeItemModel(
      title: "THOMPSON",
      subTitle: "",
      description:
          "The Thompson is a strong SMG with high damage and stability. It performs well in close to mid-range combat, making it a reliable choice for aggressive gameplay.",
      image: AppIcons.thompson,
    ),
    HomeItemModel(
      title: "WOODPECKER",
      subTitle: "",
      description:
          "The Woodpecker is a DMR with exceptional armor penetration and headshot damage. It is one of the deadliest marksman rifles in Free Fire, especially effective against heavily armored foes.",
      image: AppIcons.woodpecker,
    ),
    HomeItemModel(
      title: "XM8",
      subTitle: "",
      description:
          "The XM8 is an advanced assault rifle with excellent accuracy and low recoil. It comes with a pre-attached scope, making it versatile and efficient for medium-range combat.",
      image: AppIcons.xm8,
    ),
  ];

  List<HomeItemModel> get weapons => _weapons;

  ////////// Vehical
  final List<HomeItemModel> _vehicles = [
    HomeItemModel(
      title: "Amphibian",
      subTitle: "",
      description:
          "The Amphibian is a special vehicle in Free Fire designed to travel both on land and water. With its unique ability to switch terrains, it offers strategic advantages when rotating through rivers and lakes, keeping players unpredictable in battle.",
      image: AppIcons.amphibian,
    ),
    HomeItemModel(
      title: "Military Jeep",
      subTitle: "",
      description:
          "The Military Jeep is a durable vehicle with decent speed and strong durability. Perfect for squad rotations, it can absorb a lot of damage before being destroyed, making it a reliable option for safe zone movement.",
      image: AppIcons.militaryJeep,
    ),
    HomeItemModel(
      title: "Monster Truck",
      subTitle: "",
      description:
          "The Monster Truck is one of the toughest vehicles in Free Fire. With massive tires and extreme durability, it can crush through obstacles and withstand heavy gunfire. Its intimidating presence makes it hard to counter in open battles.",
      image: AppIcons.monsterTruck,
    ),
    HomeItemModel(
      title: "Motorcycle",
      subTitle: "",
      description:
          "The Motorcycle is a lightweight, high-speed vehicle that allows players to move quickly across the map. While it lacks durability and protection, its agility and speed make it perfect for fast rotations and hit-and-run tactics.",
      image: AppIcons.motorCycle,
    ),
    HomeItemModel(
      title: "Sports Car",
      subTitle: "",
      description:
          "The Sports Car is one of the fastest vehicles in Free Fire. Known for its incredible acceleration and sleek design, it helps players escape danger quickly or rush into battles. However, its low durability makes it vulnerable to enemy fire.",
      image: AppIcons.sportCar,
    ),
    HomeItemModel(
      title: "Tuk Tuk",
      subTitle: "",
      description:
          "The Tuk Tuk is a small three-wheeled vehicle that offers moderate speed and low durability. While not ideal for intense battles, it provides fun and quick rotations in urban areas or close-quarter zones.",
      image: AppIcons.tukTuk,
    ),
    HomeItemModel(
      title: "Veiculo Padrao",
      subTitle: "",
      description:
          "The Veiculo Padrão (Standard Car) is a balanced vehicle with decent speed and moderate durability. It is one of the most commonly found vehicles in Free Fire, making it a reliable choice for quick transportation across the map.",
      image: AppIcons.veiculoPadrao,
    ),
  ];

  List<HomeItemModel> get vehicles => _vehicles;

  final List<HomeItemModel> _dimondTips = [
    HomeItemModel(
      title: "Choose The Correct Landing Point",
      subTitle:
          "Choosing a landing point is only the first step to victory, and while it may seem trivial, it is one of the most important decisions in the game. "
          "Determining where to start correctly can make or break your chances of survival.\n\n"
          "🎯 Key Strategy:\n"
          "- The most important thing is to select a location that is isolated from other players. "
          "Look for places that are close to the city but not directly in the center of heavy activity.\n"
          "- The best option is often to land slightly outside the main town. This way, you can observe where other players are landing "
          "and then carefully move in to explore.\n"
          "- Avoid exposing yourself too much before gathering the proper equipment. Landing in hot-drop areas without armor or weapons "
          "will put you at a huge disadvantage.\n"
          "- Many areas with both quantity and quality loot will attract large numbers of players, so always balance risk and reward.\n\n"
          "✅ Pro Tip: Secure basic weapons and armor first in isolated areas, then rotate towards richer loot zones once you are better equipped.",
    ),
    HomeItemModel(
      title: "Complate in Game Achivements",
      subTitle:
          "FF has a variety of in-game achievements that players can complete to earn rewards such as diamonds, gold coins, character skins, and weapon skins. "
          "Achievements are divided into categories like combat, survival, and teamwork, giving players multiple paths to progress and earn rewards.\n\n"
          "🔥 Tips for Completing Achievements:\n"
          "1️⃣ Check the Achievement List:\n"
          "   - Open the in-game achievement menu and review all available challenges.\n"
          "   - Prioritize achievements that offer the rewards you are most interested in (diamonds, vouchers, or rare skins).\n\n"
          "2️⃣ Choose Based on Playstyle:\n"
          "   - Each achievement demands a unique approach — combat-focused, survival-oriented, or teamwork-based.\n"
          "   - Pick achievements that naturally align with your strengths and preferred playstyle.\n\n"
          "3️⃣ Set Achievable Goals:\n"
          "   - Some achievements take time and dedication, so break them down into smaller goals.\n"
          "   - Focus on completing one achievement at a time instead of trying to unlock everything at once.\n\n"
          "4️⃣ Play with Friends:\n"
          "   - Many achievements are teamwork-related (like revives, assists, or squad wins).\n"
          "   - Playing with friends not only makes these easier but also adds more fun to the grind.\n\n"
          "✅ Pro Tip: Track your progress regularly — achieving milestones steadily is better than rushing. Over time, achievements can unlock valuable resources that boost your overall game experience.",
    ),
    HomeItemModel(
      title: "Explore Miletary Sites",
      subTitle:
          "If there are no enemies in sight, it is a good idea to explore locations such as watchtowers, containers, battle bases, or military tents. "
          "These places usually contain a large amount of loot, including weapons, ammunition, and special items. \n\n"
          "⚠️ Important Tips:\n"
          "- It is not very wise to explore these areas right at the start of the game because many players land there immediately. "
          "Instead, it is recommended to explore them during the middle stages of the match when there are fewer enemies around.\n"
          "- These areas often have upgrade kits for bulletproof vests. Although you can start with a Level 1 vest, it is strongly recommended "
          "that you upgrade as soon as possible for better protection.\n"
          "- By the end of the match, surviving players will almost always carry powerful weapons. To compete effectively, make sure you "
          "collect and upgrade your gear while exploring.\n\n"
          "✅ Strategy: Stay alert when exploring loot-heavy areas, upgrade your equipment quickly, and be prepared for sudden encounters.",
    ),
    HomeItemModel(
      title: "Complete Mission",
      subTitle:
          "Free Fire offers a variety of missions that players can complete to earn exciting rewards such as character vouchers, weapon skins, and diamonds. "
          "The missions can be accessed from the in-game 'Missions' section and are updated regularly with fresh challenges.\n\n"
          "🔹 Types of Missions:\n"
          "• Daily Missions: Reset every 24 hours. They offer smaller rewards but are quick and easy to complete.\n"
          "• Weekly Missions: Reset every 7 days. These missions provide larger rewards and are slightly more challenging.\n"
          "• Event Missions: Special missions tied to limited-time in-game events. They offer unique and rare rewards such as exclusive skins or bundles.\n\n"
          "💡 Tips for Completing Missions:\n"
          "1. **Check Mission Requirements** – Some missions require specific characters, weapons, or modes. Review them before starting to avoid wasting time.\n"
          "2. **Play with Friends** – Missions that require team play are easier and more fun when completed with friends.\n"
          "3. **Stack Objectives** – Many missions share similar goals (like kills or survival time). Try completing multiple missions in a single match to save effort.\n\n"
          "✅ Completing missions regularly is one of the fastest ways to earn rewards, unlock items, and progress faster in Free Fire.",
    ),
    HomeItemModel(
      title: "Daily Login Rewards",
      subTitle: "",
    ),
    HomeItemModel(
      title: "Participate in Game Events",
      subTitle:
          "Free Fire offers daily login rewards to encourage players to stay active in the game. These rewards range from vouchers, weapon skins, gold, pet food, memory fragments, and even diamonds. "
          "The more consecutive days you log in, the greater the rewards, up to a maximum of 30 days. "
          "If you log in for 30 consecutive days, you can earn up to 100 diamonds as a reward. "
          "Note: Rewards may vary depending on your region and ongoing events, so always check the in-game events section for updates.\n\n"
          "Here’s an example of a 7-day daily login reward cycle:\n"
          "Day 1: Character Voucher\n"
          "Day 2: Diamond Royale Voucher\n"
          "Day 3: Weapon Royale Voucher\n"
          "Day 4: Gold Royale Voucher\n"
          "Day 5: Pet Food\n"
          "Day 6: Memory Fragment\n"
          "Day 7: Weapon Skin",
    ),
    HomeItemModel(
      title: "Use The Vehicle Carefully",
      subTitle:
          "In-game events are a fantastic way to earn rewards and experience new content in FF. "
          "The developers regularly host events where players can complete specific tasks and challenges to win exclusive items like skins, characters, diamonds, gold coins, and more.\n\n"
          "🔥 Tips for Participating in Events:\n"
          "1️⃣ Check the Events Tab:\n"
          "   - Open the Events tab in the main menu frequently.\n"
          "   - This section shows all ongoing and upcoming events with their requirements and rewards.\n"
          "   - Staying updated ensures you never miss valuable opportunities.\n\n"
          "2️⃣ Complete Event Tasks:\n"
          "   - Each event includes unique missions such as surviving a certain time, dealing damage, or winning matches.\n"
          "   - Completing all event tasks maximizes your reward potential.\n\n"
          "3️⃣ Participate in Limited-Time Events:\n"
          "   - Some events run only for a short duration (e.g., weekend specials, seasonal fests).\n"
          "   - Join them as soon as they launch to claim the best possible rewards before they expire.\n\n"
          "4️⃣ Use Event-Specific Items:\n"
          "   - Certain events reward you with unique items that can only be used during the event (e.g., tokens, exchange coins).\n"
          "   - Always utilize these items within the event period to unlock exclusive skins, characters, or vouchers.\n\n"
          "✅ Pro Tip: Combine daily missions with event challenges to progress faster. Many tasks overlap, so playing smart helps you earn double rewards without extra effort.",
    ),
  ];

  List<HomeItemModel> get dimondTips => _dimondTips;

  List<String> get ranked => _ranked;
  final List<String> _ranked = [
    "No-Preferane",
    "BR-Ranked",
    "CS-Ranked",
    "Casual Modes"
  ];
  List<String> get levelId => _levelId;
  final List<String> _levelId = [
    "0-25",
    "26-40",
    "41-60",
    "61-90",
    "90+",
  ];
  List<String> get selectRankImage => _selectRankImage;
  final List<String> _selectRankImage = [
    "assets/image/rank/bronze.png",
    "assets/image/rank/silver.png",
    "assets/image/rank/gold.png",
    "assets/image/rank/dimond.png",
    "assets/image/rank/platinum.png",
    "assets/image/rank/heroic.png",
    "assets/image/rank/heroic_gold.png"
  ];
}
