# To do

- Add basic physics (attach script to character body)
  - gravity
  - run (on input; use `move_toward` for accelaration; adjust existing `move_toward` to refine decelaration - divide final argument)
  - jump (on input)
- Trigger run animation frames (`$AnimatedSprite2D.play("run")` etc in physics process, and `$AnimatedSprite2D.flip_h = true` for left/right)
- Add custom input (project settings, input map) and get it working with main menu and level 1 ("move_left", "move_right", "jump", "return_to_main_menu")
- Add global return to menu function (project settings, autoload, add Global, add `_input` function with `if event.is_action_pressed("return_to_main_menu")`)
- Add camera (camera2D attached to player; zoom 3 or so; add drag)
- Connect player jump and idle animation frames
- Add portal doors
  - area 2D with collison shape 2D and animated sprite 2D child nodes
  - body entered signal on area 2D
  - save as scene and instantiate in a few places
  - `if body == $Player` move to paired door (save door reference as variable?)?
- Build out level 1
- Add level end zone/body
- Add timer
- Stop timer when you reach the end of the level
- Report time at end of level
- Collectibles - should they track across levels, prevent level doors etc or should they be more like coins where there's no real benefit to collecting them all (or should there be lives?). Should collectibles be a challenge to collect?
- Should the collectibles: count towards score (additive or multiplicative?); stop the timer temporarily; subtract from your time (e.g. -2s per collectible); give you temporary speed boost?
- Add basic jump sound effect (randomly trigger silly jump sound)
- Music

## Stretch goals

- Level end sound effect
- Redesign the sprites (make them nicer)
- Level 2 (need shared player with scene saved as script and instantiated child scenes)
- Add state machine
  - Refine jump sound effect (juh moving off ground; uhh when in air; mp when reaching the ground)
  - Trigger jump start/end when moving from/to ground
- Custom collision assets
- Custom decorative assets
- Make collision shape smaller when jumping (in line with sprite shape) [https://stackoverflow.com/questions/50725998/godot-3-0-change-collision-box-at-runtime]

## Done

- Add basic main menu
- Add level 1
- Add custom player sprite with run animation frames
- Add placeholder level assets from kenney.nl
- Design player jump and idle animation frames
- Add collision detection
  - add physics layer to tilemap
  - on tileset tab at bottom, select tiles and in physics, reset to default tile shape
  - set some to one-way in polygon to allow jump through from below, but not dropping down from above
