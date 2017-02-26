///scr_player_air()

if(state_new)
{
    image_speed=0;
    image_index=0;
    state_var[0]=false;
    state_var[1]=false;
    if(jump_held && y_speed<0)
    {
        if(abs(x_speed)>=run_max)
            state_var[1]=true;
        state_var[0]=true;   //Keep track of whether I am jumping and if I have let go of jump.
    }
}

//Adjust Y Speeds
if(jump_held && state_var[0] && state_timer < jump_hold_limit)
{
    show_debug_message("Jump Held");
    y_speed=-jump_strength;
}

if(jump_released)
    state_var[0]=false;

//Apply Gravity
y_speed=min(y_speed+grav,max_grav);

if(place_meeting_rounded(x, y+y_speed, obj_fall))
{
    room_goto(rm_game_over);
}

//Basic Vertical Collision Checking
if(place_meeting_rounded(x, y+y_speed, obj_wall))
{   //Snap to floor
    x=round(x);
    y=round(y);
    while(!place_meeting_rounded(x, y+sign(y_speed), obj_wall))
        y+=sign(y_speed);
    y_speed=0;
    state_var[0]=false;
}
else
{   //Fall
    y+=y_speed;
}

//Change Sprite
if(!state_var[1])
{
    if(y_speed>0)
        sprite_index=spr_air;
    else
        sprite_index=spr_air;
}
else
    sprite_index=spr_air;  
    
//Adjust x_speed
if(key_right||key_left)
{
    if(key_right-key_left != 0)
        image_xscale=key_right-key_left;
    x_speed=approach(x_speed, run_max * (key_right-key_left), run_acceleration)//x_speed+=(key_right-key_left)*run_accel;
}

///check for horizontal collision
if(x_speed != 0)
{
    if(place_meeting_rounded(x+x_speed, y, obj_wall))
    {
        x=round(x);
        y=round(y);
        while(!place_meeting_rounded(x+sign(x_speed), y, obj_wall))
        {
            x+=sign(x_speed);
        }
        x_speed=0;
    }
    else
        x+=x_speed;
}

//Look For State Switches
if(place_meeting_rounded(x,y+1,obj_wall) && y_speed == 0)
{
    if(x_speed==0)
        state_switch("Stand");
    else
        state_switch("Run");
}
