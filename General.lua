---------------------
-- State Variables --
---------------------

color_state = 0
gshift_state = 0
color_settings_count = 6

------------
-- Delays --
------------

move_delay = 100
click_delay = 10
user_input_delay = 600
menu_delay = 100

---------------------------
-- x, y target locations --
---------------------------

color_x = 24394
color_y = 1791

eye_x = 23029
eye_y = 1821

swap_x = 21441
swap_y = 1761

suto_size_x = 21612
suto_size_y = 1761

temp_group_1_x = 28440
temp_group_1_y = 1821
temp_group_2_x = 29737
temp_group_2_y = 2307

prim_top_x = 444
prim_top_y = 4280
prim_bot_x = 65091
prim_bot_y = 56520

shifted_prim_top_x = 427
shifted_prim_top_y = 3582
shifted_prim_bot_x = 65125
shifted_prim_bot_y = 29474

--center-ish of primary, on GW
pos0_x = 32725
pos0_y = 10897

--horiz. center of primary, on GW
pos1_x = 32725
pos1_y = 20897

--hovering on move feature
pos2_x = 32844
pos2_y = 22506

--new location of feature
pos3_x = 33152
pos3_y = 20567

---------------------
-- Handle Clicks --
---------------------

function OnEvent(event,arg)

  --OutputLogMessage("Event: "..event.." Arg: "..arg.."\n")
  --new_x, new_y = GetMousePosition()
  --OutputLogMessage("Mouse is at %d, %d\n", new_x, new_y)  
  
  if(event == "PROFILE_DEACTIVATED") then
    --OutputLogMessage("Event: "..event.." Arg: "..arg.."\n")  
  end
  if(event == "PROFILE_ACTIVATED") then
    --OutputLogMessage("Event: "..event.." Arg: "..arg.."\n")  
  end

  ------------------
  -- Toggle GShift--
  ------------------
  if(event == "MOUSE_BUTTON_PRESSED" and arg == 6) then
    gshift_state = 1
    --OutputLogMessage("GShift activaed, state: "..gshift_state.."\n")
  end
  if(event == "MOUSE_BUTTON_RELEASED" and arg == 6) then
    gshift_state = 0
    --OutputLogMessage("GShift deactivaed, state: "..gshift_state.."\n")
  end
  
  
  -----------------------
  -- Listen with GShift--
  -----------------------
  if(event == "MOUSE_BUTTON_PRESSED" and arg == 9 and gshift_state == 1) then
    --DragAcrossPrimary()
    --ShiftGW()
    --HandleColorChangeViaVirtualWheel()
    TempGroup()
  end
  
  if(event == "MOUSE_BUTTON_PRESSED" and arg == 10 and gshift_state == 1) then
    --ToggleEyeShadow()
    --TempGroup()
    ToggleSwapIDOD()
    
  end
  
  if(event == "MOUSE_BUTTON_PRESSED" and arg == 11 and gshift_state == 1) then
        --ToggleColorSettings()
  end
  
  if(event == "MOUSE_BUTTON_PRESSED" and arg == 12 and gshift_state == 1) then
    --ToggleMlAutoSize()
  end
  
  if(event == "MOUSE_BUTTON_PRESSED" and arg == 13 and gshift_state == 1) then
    DragAcrossPrimary()
    --PrintMouseCoords()
  end         
  
  if(event == "MOUSE_BUTTON_PRESSED" and arg == 20 and gshift_state == 1) then
    
  end 
  
  ----------------------
  --Listen GShift OFF --   
  ----------------------
  if(event == "MOUSE_BUTTON_PRESSED" and arg == 10 and gshift_state == 0) then
    --ShiftGW()
  end
  
  if(event == "MOUSE_BUTTON_PRESSED" and arg == 13 and gshift_state == 0) then
    --ShiftGW()
  end
   
  
  -------------
  -- Keyboard--
  -------------
  if(event == "G_PRESSED" and arg == 4) then
    --ShiftGW()
  end
  
  if(event == "G_PRESSED" and arg == 5) then
    --PlayMacro("Auto Database Down")
  end
  
end

------------
-- Macros --
------------
function ShiftGW()
  --get current location of mouse
  new_x, new_y = GetMousePosition()

  --move mouse so that it can select and move GW feature
  MoveMouseTo(pos1_x,pos1_y)
  ClickHandler(3, false, false)
  Sleep(100)
  -- move mouse so that it can click the correct menu item
  MoveMouseTo(pos2_x,pos2_y)
  ClickHandler(1, false, false)
  Sleep(menu_delay)
  
  --move mouse to target location
  --MoveMouseTo(pos3_x,pos3_y)
  MoveMouseTo(new_x,new_y)
  ClickHandler(1, false, false)
  Sleep(menu_delay)
  
  --move mouse back to home position
  --MoveMouseTo(pos0_x,pos0_y)
  MoveMouseTo(pos3_x,pos3_y-10000)
  PlayMacro("Database Down")
end  

function DragAcrossPrimary()
  ClickDragReturn(prim_top_x, prim_top_y, prim_bot_x, prim_bot_y)
end

function ShiftedDragAcrossPrimary()
  ClickDragReturn(shifted_prim_top_x, shifted_prim_top_y, shifted_prim_bot_x, shifted_prim_bot_y)
end

function ToggleMlAutoSize()
    ClickReturn(suto_size_x ,suto_size_y)
end

function ToggleSwapIDOD()
    ClickReturn(swap_x,swap_y)
end

function ToggleEyeShadow()
    ClickReturn(eye_x, eye_y)
end

function TempGroup()
  new_x, new_y = GetMousePosition()
  -- Move and click 1
  MoveMouseTo(temp_group_1_x ,temp_group_1_y)
  ClickHandler(3, false, false)
  
  -- Wait for menu
  Sleep(menu_delay)
  
  -- Move and click 2
  MoveMouseTo(temp_group_2_x ,temp_group_2_y)
  ClickHandler(1, false, false)
  MoveMouseTo(new_x, new_y)
  
  -- Wait for temp group to calc. then press
  -- escape to dismiss msg box
  Sleep(menu_delay * 15)
  PressKey(0x01)
  
end

function ToggleColorSettings()
  new_x, new_y = GetMousePosition()
  MoveMouseTo(color_x,color_y)
  ClickHandler(3, false, false)
  if(color_state == 0) then
    PlayMacro("Select Dark Color Settings")
    color_state = 1
  elseif(color_state == 1) then
    PlayMacro("Select Normal Color Settings")
    color_state = 0
  end
  Sleep(100)    
  MoveMouseTo(new_x,new_y)
end

function HandleColorChangeViaVirtualWheel()

  OutputLogMessage("Virt CW\n")
  
  -- 1) Remember start position
  local start_x, start_y = GetMousePosition()
  
  -- 2) Give user a brief moment to move the mouse
  Sleep(user_input_delay)
  
  -- 3) Remember end position
  local end_x, end_y = GetMousePosition()
  
  -- 4) Compute angle from 12 o'clock, clockwise
  local dx = end_x - start_x
  local dy = start_y - end_y
  local raw_angle = math.deg(math.atan(dx, dy))  -- atan(dx, dy) gives angle relative to vertical
  if raw_angle < 0 then
    raw_angle = raw_angle + 360
  end
  
  -- 5) Determine which slice (1-indexed)
  local slice_size = 360 / color_settings_count
  local slice = math.floor(raw_angle / slice_size) + 1
  
  OutputLogMessage("slice: %d\n", slice)  
  
  -- 6) Open the color menu
  MoveMouseTo(color_x, color_y)
  ClickHandler(3, false, false)  -- right-click
  
  -- 7) Navigate to the chosen slice
  for i = 1, slice do
    OutputLogMessage("loop: %d || ", i)
    PressAndReleaseKey("down")
    Sleep(click_delay)
  end
  PressAndReleaseKey("enter")
  
  -- 8) Return cursor
  MoveMouseTo(start_x, start_y)
end


---------------
-- Utilities --
---------------

function ClickReturn(x, y)
  new_x, new_y = GetMousePosition()
  MoveMouseTo(x,y)
  ClickHandler(1, false, false)
  MoveMouseTo(new_x, new_y)
end

function ClickDragReturn(x1, y1, x2, y2)
  new_x, new_y = GetMousePosition()
  MoveMouseTo(x1, y1)
  ClickHandler(1, true, false)
  MoveMouseTo(x2,y2)
  ClickHandler(1, false, true)
  MoveMouseTo(new_x, new_y)
end

function ClickHandler(mouseButtton, pressOnly, releaseOnly)
  Sleep(move_delay)
  if (pressOnly == false and releaseOnly == false) then
    PressAndReleaseMouseButton(mouseButtton)
  elseif (pressOnly  == true and releaseOnly == false) then
    PressMouseButton(mouseButtton)
  elseif (releaseOnly == true and pressOnly == false) then
    ReleaseMouseButton(mouseButtton)
  end
  Sleep(click_delay)
end

function PrintMouseCoords()
  new_x, new_y = GetMousePosition()
  OutputLogMessage("Mouse is at %d, %d\n", new_x, new_y)  
end
