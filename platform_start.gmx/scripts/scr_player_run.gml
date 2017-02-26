
if(state_new)
{
    sprite_index = spr_run;
    image_index = 1;
}

if( place_meeting_rounded(x+x_speed, y, obj_parent_enemy) )
{
    state_switch("Hit", obj_parent_enemy.damage)
}

if( key_left || key_right )
{
    //speed up
    x_speed=approach(x_speed, run_max * (key_right-key_left), walk_acceleration);
}
else
{   
    //slow down
    x_speed=approach(x_speed,0,walk_acceleration);
}

if( x_speed==0 )
{
    state_switch("Stand");
}
else
{
    if(key_right)
        image_xscale=1;
    else if(key_left)
        image_xscale=-1;
        
    sprite_index = spr_run;
    image_speed=lerp(0,.4,abs(x_speed)/run_max);
}

if(!place_meeting_rounded(x,y+1,obj_wall))
{
    state_switch("Air");
}

if(place_meeting_rounded(x+x_speed,y,obj_wall))
{
    x=round(x);
    y=round(y);
    while(!place_meeting_rounded(x+sign(x_speed),y,obj_wall))
    {
        x+=sign(x_speed);
    }
    x_speed=0;
    state_switch("Stand");
}
else
{
    x += x_speed;
}

if(jump_pressed)
{ 
    state_switch("Air");
    y_speed-=jump_strength;
}

