# Vanilla++ V1

**Thanks to SirPlease and the many people who have worked on the [Competitive Rework](https://github.com/SirPlease/L4D2-Competitive-Rework), which I've used as an inspiration and base for this project.
Special thanks to the people who helped testing this project out.**

## General Changes
### **Bug Fixes**
- Hittables will now give the correct amount of damage points.
---
### **Scoring Changes**
- Defib penalty has been increased to 100pts (Vanilla: 25pt)
---
### **Director Changes**
- Wandering witches have been removed
- Random hordes have been removed
- Tanks and Witches are now guaranteed to spawn on every map
- Tanks and Witches should spawn in the same spot for both teams
---
### **Survivor Changes**
- Friendly fire from guns has been removed
- Survivors respawn health has been reduced to 35 (Vanilla: 50)
---
### **Item Changes**
- First aid kits now only heal 75% of the survivors lost HP (Vanilla: 80%)
- Melee weapon damage against the tank has been reduced by 30%
- Molotov spread radius has been reduced by 50%
- Laser sight accuracy buff has been reduced by 67%
---
### **Infected Changes**
- Jockey resistance has been removed
- Jockey riding speed has been decreased by 4%
- Special infected will no longer get slowed down when shot
- Special infected no longer stay permanently ignited. Fire will now extinguish in 12s.
- Infected can now break down doors with 1 attack
- Witch damage to incapped survivors has been increased by 133%
- Tank slow down when being shot has been reduced by 50%. Slowdown range has been reduced to 250 (Vanilla: 400).
- Tanks can now choose which rock they throw (Mouse2/E/R)
- Hittables will now glow for the infected team after being hit

## **Weapon Changes**

[**Weapon Stats Spreadsheet**](https://docs.google.com/spreadsheets/d/1cAw2On5WIPHb31GaRuGyi9Qq2bmMfM_AP3s2jXNHIOA/edit?usp=sharing)

### **Snipers**
- **Military Rifle**
    - Reload duration increased to 3.55 (Vanilla 3.33)
    - Max movement spread increased to 7 (Vanilla: 3)
    - Dropoff multiplier decreased to 0.98 (Vanilla: 1.0)
    - Damage dropoff range changed to 1200 (Vanilla: None)
    - Clip size decreased to 25 (Vanilla: 30)
    - Reserve ammo decreased to 120 (Vanilla: 180)
    - Tank damage multiplier added (0.80x)
- **Hunting Rifle**
    - Dropoff multiplier decreased to 0.98 (Vanilla: 1.0)
    - Damage dropoff range changed to 1200 (Vanilla: None)
    - Reserve ammo decreased to 120 (Vanilla: 180)
    - Tank damage multiplier added (0.80x)
- **AWP**
    - Max movement spread increased to 7(Vanilla: 3)
    - Damaged increased to 175 (Vanilla: 115)
    - Damage dropoff multiplier decreased to 0.98 (Vanilla: 1.0)
    - Damage dropoff range changed to 1200 (Vanilla: None)
    - Clip size decreased to 10 (Vanilla: 20)
    - Reserve ammo decreased to 120 (Vanilla: 180)
    - Tank damage multiplier added (1.15x)
- **Scout**
    - Damaged increased to 115 (Vanilla: 105)
    - Reload duration decreased to 2.4s (Vanilla 2.9s)
    - Dropoff multiplier decreased to 0.98 (Vanilla: 1.0)
    - Damage dropoff range changed to 1200 (Vanilla: None)
    - Reserve ammo decreased to 120 (Vanilla: 180)
    - Tank damage multiplier added (1.15x)
---
### **Assault Rifles** 
- **AK47**
    - Damage decreased to 50 (Vanilla: 58)
    - Max range increased to 4650 (Vanilla: 3000)
    - Damage dropoff range decreased to 1200 (Vanilla: 1500)
    - Damage dropoff multiplier decreased to 0.95 (Vanilla: 0.97)
    - Tank damage multiplier applied (0.95x)
- **SCAR**
    - Reload duration decreased to 3.1s (Vanilla 3.3s)
    - Max range increased to 4200 (Vanilla: 3000)
    - Damage dropoff range decreased to 1200 (Vanilla: 1500)
    - Damage dropoff multiplier decreased to 0.95 (Vanilla: 0.97)
    - Tank damage multiplier added (0.90x)
- **M16**
    - Damage increased to 38 (Vanilla: 33)
    - Reload duration increased to 2.35s (Vanilla: 2.2s)
    - Max range increased to 4200 (Vanilla: 3000)
    - Damage dropoff range decreased to 1200 (Vanilla: 1500)
    - Damage dropoff multiplier decreased to 0.87 (Vanilla: 0.97)
    - Tank damage multiplier added (0.85x)
- **SG552**
    - Damage increased to 36 (Vanilla: 33)
    - Reload duration decreased to 3.2s (Vanilla: 3.4s)
    - Max range increased to 5400 (Vanilla: 3000)
    - Damage dropoff range decreased to 1200 (Vanilla: 1500)
    - Tank damage multiplier added (0.95x)
---
### **Autoshotguns**
- **Tactical Shotgun**
    - Reload duration increased to 0.473s per shell (Vanilla: 0.393s)
    - Clip size decreased to 7 (Vanilla: 10)
    - Damage dropoff range changed to 1200 (Vanilla: None) 
- **Combat Shotgun**
    - Reload duration increased to 0.473s per shell (Vanilla: 0.393s)
    - Clip size decreased to 7 (Vanilla: 10)
    - Damage dropoff range changed to 1200 (Vanilla: None) 
---
### **SMGS**
- **MAC-10**
    - Damage dropoff range decreased to 800 (Vanilla: 900)
    - Damage dropoff multiplier decreased to 0.77 (Vanilla: 0.84)
- **Uzi**
    - Damage increased to 24 (Vanilla: 20)
    - Reload duration decreased to 1.9s (Vanilla 2.24s)
    - Damage dropoff range decreased to 800 (Vanilla: None)
    - Damage dropoff multiplier increased to 0.85 (Vanilla: 0.84)
    - Tank damage multiplier added (0.85x)
- **MP5**
    - Damage increased to 28 (Vanilla: 26)
    - Reload duration decreased to 2.5s (Vanilla: 2.9s)
    - Max range increased to 3200 (Vanilla 2500)
    - Damage dropoff range decreased to 800 (Vanilla: None)
    - Damage dropoff multiplier increased to 0.87 (Vanilla: 0.84)
    - Tank damage multiplier added (0.95x)
---
### **Pump Shotguns**
- **Pump Shotgun**
    - Pellets increased to 16 (Vanilla: 10)
    - Damage decreased to 17 (Vanilla 25)
    - Max range decreased to 2500 (Vanilla: 3000)
    - Dropoff damage range changed to 800 (Vanilla: None)
- **Chrome Shotgun**
    - Max range decreased to 2500 (Vanilla: 3000)
    - Dropoff damage range changed to 800 (Vanilla: None)
---
### **Pistols**
- **Magnum**
    - Max range decreased to 2500 (Vanilla: 3000)
    - Dropoff damage range changed to 800 (Vanilla: None)
    - Damage dropoff multiplier increased to 0.8 (Vanilla: 0.75)
- **Pistol**
    - Max range decreased to 2500 (Vanilla: 3000)
    - Dropoff damage range changed to 800 (Vanilla: None)
- **Dual Pistols**
    - Max range decreased to 2500 (Vanilla: 3000)
    - Dropoff damage range changed to 800 (Vanilla: None)

## Map Changes
### Dead Center
#### **Map 1**
- **Items & Weapons**
    - Tier 1 gun spawns added to the start. 

        ![Image](https://i.imgur.com/twgOXFW.jpg) 
        
    - Medical cabinet added in the security office after the elevator event.
        
        ![Image](https://i.imgur.com/Iw6WHi5.jpg)
        
- **Ammo Piles**
    - Map room by the start. 
        
        ![Image](https://i.imgur.com/XrrSTqd.jpg)
        
    - Elevator room. 
        
        ![Image](https://i.imgur.com/FBFcU8q.jpg)
        
- **Props**
    - Collision added to the railings in the elevator. Allows survivors to avoid spit damage. 
        
        ![Image](https://i.imgur.com/gb46YHv.jpg)
        

#### **Map 2**
- **Items & Weapons**
    - Medical cabinet added in the grocery store by the cola.
        
        ![Image](https://i.imgur.com/rNnolxP.jpg)
        

#### **Map 3**
- **Director & Events**
    - Event pathing has been changed. Both pathways are open (the toystore, and lower hallway) but in order to progress through the map survivors will need to go to the lower hallway. The toystore room provides a spot to fight tanks, and extra pills if needed. 
        
        ![Image](https://i.imgur.com/LWEZRiy.jpg) ![Image](https://i.imgur.com/rA3zZmJ.jpg) ![Image](https://i.imgur.com/ahMuZ9M.jpg)
        
    - Event pathing has been changed. Escalators will now spawn on the right side of the room during the gauntlet event. 
        
        ![Image](https://i.imgur.com/0u1dudx.jpg)
        
- **Props**
    - Added a barrier to prevent survivors going all the way down the hallway leading to the toystore room. 
        
        ![Image](https://i.imgur.com/uGE6TRI.jpg)
        
    - Infected are now able to break the bathroom wall and use this as a path to get to the survivors instead of using the ventilation shaft. 
        
        ![Image](https://i.imgur.com/6vDnbbh.jpg) ![Image](https://i.imgur.com/OsyJl2A.jpg)
        
    - Added a scaffold to nerf the death pull on the escalator to try and encourage more variety in where infected choose to attack. Survivors can still take fall damage but won't die if pulled off. 
        
        ![Image](https://i.imgur.com/1Uyl6n8.jpg)
        
    - Added barriers to the top floor to prevent survivors from back pedaling the whole time during tank fights. 
        
        ![Image](https://i.imgur.com/bdjy358.jpg) ![Image](https://i.imgur.com/gEpjJNt.jpg)
        
- **Ammo Piles**
    - Lobby room.
        
        ![Image](https://i.imgur.com/zytwfHS.jpg)
        
    - Lower hallway.
        
        ![Image](https://i.imgur.com/TdpfpkI.jpg)
        
    - Outside security office.
        
        ![Image](https://i.imgur.com/hzYlqhW.jpg)
        

#### **Map 4**
- **Props**
    - Added railing prop in the elevator and gave it collision. Allows survivors to avoid spit damage. 
        
        ![Image](https://i.imgur.com/g4CAAsp.jpg)
        
---
### Dark Carnival
#### **Map 1**
- **Items & Weapons**
    - Added pills in the new ambulance on the highway. 
        
        ![Image](https://i.imgur.com/IjMPQUk.jpg)
        
- **Props**
    - Added ambulance on the highway after the motel.
        
        ![Image](https://i.imgur.com/IjMPQUk.jpg)
        
- **Ammo Piles**
    - Humvee near underpass.
        
        ![Image](https://i.imgur.com/sybxOBP.jpg)
        
    - Motel room at the end of the motel area.
        
        ![Image](https://i.imgur.com/B83EJzg.jpg)
        
    - Outhouse by the hill.
        
        ![Image](https://i.imgur.com/34k1PT3.jpg)
        

#### **Map 2**
- **Ammo Piles**
    - Tent by the ramp before kiddyland.
        
        ![Image](https://i.imgur.com/pCAeZlj.jpg)
        
    - Under balcony by the event.
        
        ![Image](https://i.imgur.com/XGeTIZD.jpg)
        

#### **Map 3**
- **Ammo Piles**
    - Second painting in the tunnel of love.
        
        ![Image](https://i.imgur.com/EAXubSu.jpg)
        
    - Office with pill cabinet.
        
        ![Image](https://i.imgur.com/RSZsFVh.jpg)
        

#### **Map 4**
- **Items & Weapons**
    - Medical cabinet added in the booth before the barn. 
        
        ![Image](https://i.imgur.com/kAG6Atv.jpg)
        
- **Ammo Piles**
    - Picnic tables outside the barn.
        
        ![Image](https://i.imgur.com/JDNvsmi.jpg)
        

#### **Map 5**
- **Director & Events**
    - Rescue helicopter is now forced to land on the left side of the concert area. 
        
        ![Image](https://i.imgur.com/81iDXvv.jpg)
        
- **Props**
    - Fence added onto both the right and left bathrooms at the top of the seating area to allow infected to spawn a bit easier. 
        
        ![Image](https://i.imgur.com/DkpyssP.jpg) ![Image](https://i.imgur.com/HVCayXp.jpg)
        
---
### Swamp Fever
#### **Map 1**
- **Weapons & Items**
    - Medical cabinet added into the standard holdout house by the ferry event.
        
        ![Image](https://i.imgur.com/wUAAp4Q.jpg)
        
    - Changed the guaranteed sniper spawn to a hunting rifle and moved it to outside one of the shanty houses.
        
        ![Image](https://i.imgur.com/l5hNeW2.jpg)
        ![Image](https://i.imgur.com/dgc17nz.jpg)
        
- **Props**
    - Added SUV on the road outside the start saferoom.
        
        ![Image](https://i.imgur.com/EHCPjZN.jpg)
        
    - Added rocks outside the start saferoom.
        
        ![Image](https://i.imgur.com/Z45rs1V.jpg)
        
- **QOL Changes**
    - Fixed the ladder on the house by the ferry event being hard to climb.
        
        ![Image](https://i.imgur.com/PaU9rZZ.jpg)
        
- **Visual Effects**
    - Added a semi-dense fog to the map to obscure the survivors vision a bit.
        
        ![Image](https://i.imgur.com/h8ZCqn4.jpg)
        
- **Ammo Piles**
    - Outside the two story house before the small town.
        
        ![Image](https://i.imgur.com/C2tUodF.jpg)
        
    - By the picnic tables after the ferry event.
        
        ![Image](https://i.imgur.com/Q0PeOfa.jpg)
        
    - Ontop the table on the wooden walkway.
        
        ![Image](https://i.imgur.com/QWVcUVy.jpg)
        

#### **Map 2**
- **Weapons & Items**
    - Changed the Tier 2 weapons at the start to be random Tier 1 weapons.
        
        ![Image](https://i.imgur.com/dOkwEpq.jpg)
        
    - Medical cabinet added into the shack after the plane event.
        
        ![Image](https://i.imgur.com/OBHnEis.jpg)
        
- **Props**
    - Added extra bushes by the campfire after the plane event.
        
        ![Image](https://i.imgur.com/EzImV3v.jpg)
        ![Image](https://i.imgur.com/nSeVMMg.jpg)
        
- **Visual Effects**
    - Added a dense fog to the map to obscure the survivors vision.
        
        ![Image](https://i.imgur.com/MqS9Xgo.jpg)
        
- **Ammo Piles**
    - By the campfire after the plane event
        
        ![Image](https://i.imgur.com/uLIX9W3.jpg)
        

#### **Map 3**
- **Weapons & Items**
    - Added a medical cabinet in the shack leading to the swamp area
        
        ![Image](https://i.imgur.com/OSJ4bok.jpg)
        
- **Props**
    - Added several "hunting platforms" in some of the trees in the swamp area.
        
        ![Image](https://i.imgur.com/3XoYJh5.jpg)
        ![Image](https://i.imgur.com/dP8Ex6T.jpg)
        ![Image](https://i.imgur.com/NTqg1Cw.jpg)
        
- **Visual Effects**
    - Added a dense fog to the map to obscure the survivors vision.
        
        ![Image](https://i.imgur.com/W8J3JmZ.jpg)
        
- **Ammo Piles**
    - Inside the shanty house at the start of the walkway.
        
        ![Image](https://i.imgur.com/uBZeZNX.jpg)
        
    - By the lantern before the event.
        
        ![Image](https://i.imgur.com/zhkK20r.jpg)
        
