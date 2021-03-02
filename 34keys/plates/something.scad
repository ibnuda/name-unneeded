module
shape_of_pcb()
{
    import("edge-cuts.dxf");
}

module
base_shape()
{
    linear_extrude(height = 15) offset(10) shape_of_pcb();
}

module
inner_space()
{
    linear_extrude(height = 15) offset(0.5) shape_of_pcb();
}

module
promicro_trrs_space()
{
    linear_extrude(height = 12) polygon(points = [
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
spacer_thing()
{
    translate([0, 0, 4]) cylinder(r = 2.1, h = 8, center = true);
}

module
bottom_hull()
{
    hull()
    {
        children();
        linear_extrude(height = 1) projection() children();
    }
}

mirror([1, 0, 0]) 
union()
{
    difference()
    {
        base_shape();
        translate([ 0, 0, 4 ]) inner_space();
        translate([ 0, 0, 4 ]) promicro_trrs_space();
        for (i = [0:20]) {
            translate([ (i * 10), 0, 0 ])
                cube(size = [ 3, 500, 3 ], center = true);
        }
    }
    translate([ 39.5, -48.5, 4 ]) spacer_thing();
    translate([ 39.5, -67.5, 4 ]) spacer_thing();
    translate([ 96.5, -39.5, 4 ]) spacer_thing();
    translate([ 96.5, -58.5, 4 ]) spacer_thing();
    translate([ 113.5, -91.5, 4 ]) spacer_thing();
}

/*
difference()
{
    translate([ 0, 0, -10 ]) difference()
    {
        bottom_hull() rotate([ 0, -20, 0 ]) base_shape();
        rotate([ 0, -20, 0 ]) translate([ 0, 0, 4 ]) inner_space();
        rotate([ 0, -20, 0 ]) translate([ 0, 0, 4 ]) promicro_trrs_space();
        translate([ 0, 0, -10 ]) bottom_hull() rotate([ 0, -20, 0 ])
            linear_extrude(height = 1) offset(0.5) shape_of_pcb();
    }
    translate([ 0, 0, -125 ]) cube(size = [ 350, 350, 250 ], center = true);
}
*/