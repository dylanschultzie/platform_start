///scr_player_stand
if(state_new)
{
    x_speed=0;
    y_speed=0;
    image_speed=0;
    sprite_index=spr_stand;
    image_index=0;
}

if( key_right && !place_meeting_rounded(x+1, y, obj_wall) ||
    key_left && !place_meeting_rounded(x-1, y, obj_wall))
{
    state_switch("Run");
}

if(jump_pressed)
{
    state_switch("Air");
    y_speed -= jump_strength;
}

if(!position_meeting_rounded(x, y-1, obj_wall))
{
//    state_switch("Air");
}
