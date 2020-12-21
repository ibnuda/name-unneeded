
tenting_screw_positions =
    [ [ 130, -113 ], [ 40, -11 ], [ 106.5, -11 ], [ 14, -58 ], [ 141, -35 ] ];

stagger = [ -39, -27, -21, -28, -30 ];

module alpha_holes(width = 14)
{
    for (j = [0:2])
        for (i = [0:4])
            translate([ (30 + i * 19), (stagger[i] - j * 19), 0 ])
                square(size = [ width, width ], center = true);
}

module thumb_holes(width = 14)
{
    union()
    {
        translate([ 78.5, -85, 0 ]) rotate([ 0, 0, 0 ])
            square(size = [ width, width ], center = true);

        translate([ 100.9, -90.3, 0 ]) rotate([ 0, 0, 333.4 ])
            square(size = [ width, width ], center = true);

        translate([ 118.6, -103.5, 0 ]) rotate([ 0, 0, 313.4 ])
            square(size = [ width, width ], center = true);
    }
}

module
promicro_trrs_space()
{
    polygon(points = [
        [ 116, -5 ],
        [ 116, -55.5 ],
        [ 121, -55.5 ],
        [ 121, -72 ],
        [ 155, -72 ],
        [ 155, -55.5 ],
        [ 135, -55.5 ],
        [ 135, -5 ]
    ]);
}

module
shape_of_pcb()
{
    import("edge-cuts.dxf");
}

module
room_of_pcb()
{
    offset(1) shape_of_pcb();
}

module
bun()
{
    translate([ 0, 0, 3 ]) minkowski()
    {
        sphere(r = 3, $fn = 30);
        linear_extrude(height = 0.01) offset(10) shape_of_pcb();
    }
}

module
meat()
{
    translate([ 0, 0, 3 ]) linear_extrude(height = 20) offset(13)
        shape_of_pcb();
}

module
base_shape()
{
    union()
    {
        bun();
        meat();
        translate([ 0, 0, 20 ]) bun();
    }
}

module case ()
{
    difference()
    {
        base_shape();
        translate([ 0, 0, 3 ]) linear_extrude(height = 4) room_of_pcb();
        translate([ 0, 0, 3 ]) linear_extrude(height = 12)
            promicro_trrs_space();
        translate([ 0, 0, 7 ]) linear_extrude(height = 5) alpha_holes();
        translate([ 0, 0, 7 ]) linear_extrude(height = 5) thumb_holes();
        translate([ 0, 0, 12 ]) linear_extrude(height = 15) alpha_holes(19.5);
        translate([ 0, 0, 12 ]) linear_extrude(height = 15) thumb_holes(19.5);
    }
}

module
bowl()
{
    intersection()
    {
      case();
      cube(size = [400, 400, 14], center = true);
    }
}

module
lid()
{
    difference()
    {
      case();
      cube(size = [400, 400, 14], center = true);
    }
}

bowl();
translate([150, 0, -7]) lid();