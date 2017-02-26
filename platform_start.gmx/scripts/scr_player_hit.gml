if(state_new)
{
    hit_recoil = 2;
    if( argument_count > 0)
    {
        damage = argument0;
    }
    else
    {
        damage = 1;
    }
   
    health -= damage; 
    if( health < 0 )
    {
        health = 0;      
    }
}

if( health == 0 )
{
    room_goto(rm_game_over);
}

if(place_meeting_rounded(x-hit_recoil, y, obj_wall))
{
    
}
