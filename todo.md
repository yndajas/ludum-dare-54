# To do

- Stop timer when you reach the end of the level
- Report time at end of level
- Level end sound effect

## Stretch goals

- Redesign the sprites (make them nicer)
- Custom collision assets
- Custom decorative assets
- Collectibles - should they track across levels, prevent level doors etc or should they be more like coins where there's no real benefit to collecting them all (or should there be lives?). Should collectibles be a challenge to collect?
- Should the collectibles: count towards score (additive or multiplicative?); stop the timer temporarily; subtract from your time (e.g. -2s per collectible); give you temporary speed boost?
- Hide cursor in full screen mode if keyboard or controller is used but reveal again when mouse moves [https://www.youtube.com/watch?v=-nNxUiHJ97]
- Level 2 (need shared player with scene saved as script and instantiated child scenes)
- Add state machine
  - Refine jump sound effect (juh moving off ground; uhh when in air; mp when reaching the ground)
  - Trigger jump start/end when moving from/to ground
- Death when falling out of bounds
- Make collision shape smaller when jumping (in line with sprite shape) [https://stackoverflow.com/questions/50725998/godot-3-0-change-collision-box-at-runtime]
- Refactor door entered repositioning - create an abstract receiving door and move to an instance of that?

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
- Add basic physics (attach script to character body)
  - gravity
  - run (on input; use `move_toward` for accelaration; adjust existing `move_toward` to refine decelaration - divide final argument)
  - jump (on input)
- Trigger run/jump animation frames (`$AnimatedSprite2D.play("run")` etc in physics process, and `$AnimatedSprite2D.flip_h = true` for left/right)
- Get main menu working with controller/keyboard - auto-focus button
- Add custom input (project settings, input map) and get it working with main menu and level 1 ("move_left", "move_right", "jump", "return_to_main_menu")
- Add global return to menu function (project settings, autoload, add Global, add `_input` function with `if event.is_action_pressed("return_to_main_menu")`)
- Add camera (camera2D attached to player; zoom 3 or so; add drag)
- Add portal doors
  - area 2D with collison shape 2D and animated sprite 2D child nodes
  - body entered signal on area 2D
  - save as scene and instantiate in a few places
  - `if body == $Player` move to other door
- Build out level 1
- Add debug mode reset button
- Add full screen toggle in main menu
- Add quit button
- Add basic jump sound effect (randomly trigger silly jump sound)
- Music
- Music mute button/key
- Refactor random jump trigger to use single audio player like music
- Menu sound effects
- Hide full screen and exit buttons on non-PC builds
- Add timer
- Add level end zone/body
- Stop player when goal reached
- Change door node to Sprite2D
