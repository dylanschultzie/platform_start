if(state_new)
{
    if( argument_count > 0)
    {
        //this isn't working for some reason. I need to figure out how to do direction as well.
        damage = argument0;
        hit_recoil = argument1;
        hit_direction = argument2;
    }
    else
    {
        damage = 1;
        hit_recoil = 2;
        hit_direction = -1;
    }
    
    health -= damage; 
    if( health < 0 )
    {
        health = 0;      
    }
    recoil_direction = hit_direction * hit_recoil;
}

if( health == 0 )
{
    room_goto(rm_game_over);
}

if(!place_meeting_rounded(x+recoil_direction, y, obj_wall))
{
    x += recoil_direction * 32;
    state_switch("Stand");
}
else
{
    x=round(x);
    y=round(y);
    while(!place_meeting_rounded(x+sign(recoil_direction * 32), y, obj_wall))
    {
        x+=sign(recoil_direction * 32);
    }
    recoil_direction=0;
    state_switch("Stand");
}
