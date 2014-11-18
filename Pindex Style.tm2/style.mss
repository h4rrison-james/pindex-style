// ---------------------------------------------------------------------
// Colours

// Base
@water: #ddeeff;
@land: #fffee5;
@line: #226688;

// Land Use
@park: #aadb78;
@hospital: #fde;
@school: #f0e8f8;
@wood: #6a4;

// Geography Colours
@white: #F0F8FF;
@red: #fdaf6b;
@orange: #fdc663;
@yellow: #fae364;
@green: #d3e46f;
@turquoise: #aadb78;
@blue: #a3cec5;
@purple: #ceb5cf;
@pink: #f3c1d3;

// Testing
@f00: #f00;

#bounding-box::bottom {
  [zoom<=8] { polygon-fill: @water; }
  [zoom>=9] { 
    polygon-fill: @land;
    comp-op: hard-light;
  }
}


// ---------------------------------------------------------------------
// Political boundaries

#admin [zoom>=9] {
  line-join: round;
  line-cap: round;
  line-color: @line;
  // Countries
  [admin_level=2] {
    ::tint {
      opacity: 0.2;
      image-filters: agg-stack-blur(5,5);
      [zoom>=8] { line-width: 4; }
      [disputed=1] { line-dasharray: 4,4; }
      [maritime=1] { opacity:0; }
    }
    ::inner {
      line-width: 0.8;
      opacity: 0.3;
      [zoom>=8] { line-width: 1; }
      [disputed=1] { line-dasharray: 1,1; }
      [maritime=1] { line-color: @water; }
    }
  }
  // States / Provices / Subregions
  [admin_level>=3] {
    line-width: 0.3;
    opacity: 0.3;
    line-dasharray: 10,3,3,3;
    [zoom>=6] { line-width: 1; }
    [zoom>=8] { line-width: 1.5; }
    [zoom>=12] { line-width: 2; }
  }
}


// ---------------------------------------------------------------------
// Water Features 

#water [zoom>=9] {
  polygon-fill: @water;
  
  ::tint-bands {
    opacity: 0.1;
    line-join: round;
    line-cap:round;
    image-filters: agg-stack-blur(5,5);
    line-width: 5;
  }
  ::inner {
    line-color:@line;
    line-opacity:0.6;
    line-join:round;
    line-cap:round;
    line-width: 1;
  }
  //comp-op: hard-light;
  // We should add some noise to the water here later
  //polygon-pattern-file: url(pattern/light_toast.png);
  //polygon-pattern-comp-op: overlay;
  [zoom<=5] {
    // Below zoom level 5 we use Natural Earth data for water,
    // which has more obvious seams that need to be hidden.
    //polygon-gamma: 0.4;
  }
}

#waterway [zoom>=9] {
  line-color: @water * 0.9;
  line-cap: round;
  line-width: 0.5;
  [class='river'] {
    [zoom>=12] { line-width: 1; }
    [zoom>=14] { line-width: 2; }
    [zoom>=16] { line-width: 3; }
  }
  [class='stream'],
  [class='stream_intermittent'],
  [class='canal'] {
    [zoom>=14] { line-width: 1; }
    [zoom>=16] { line-width: 2; }
    [zoom>=18] { line-width: 3; }
  }
  [class='stream_intermittent'] { line-dasharray: 6,2,2,2; }
}

// ---------------------------------------------------------------------
// Landuse areas 

#landuse[zoom>8] {
  // Land-use and land-cover are not well-separated concepts in
  // OpenStreetMap, so this layer includes both. The 'class' field
  // is a highly opinionated simplification of the myriad LULC
  // tag combinations into a limited set of general classes.
  [class='park'] { opacity: 0.2; polygon-fill: @park; }
  [class='cemetery'] { polygon-fill: mix(@park, #ddd, 25%); }
  [class='hospital'] { polygon-fill: @hospital; }
  [class='school'] { polygon-fill: @school; }
  ::overlay {
    // Landuse classes look better as a transparent overlay.
    opacity: 0.3;
    [class='wood'] { polygon-fill: @park; polygon-gamma: 0.5; }
  }
}

// ---------------------------------------------------------------------
// Buildings

#building {
  // At zoom level 13, only large buildings are included in the
  // vector tiles. At zoom level 14+, all buildings are included.
  polygon-fill: @yellow;
  polygon-opacity: 0.4;
  opacity: 0.5;
  [zoom>=17] {
    line-color: @yellow;
    line-width: 1;
    line-clip: false;
  }
}

// ---------------------------------------------------------------------
// Aeroways 

#aeroway [zoom>=12] {
  ['mapnik::geometry_type'=2] {
    line-color: @land * 0.96;
    [type='runway'] { line-width: 5; }    
    [type='taxiway'] {  
      line-width: 1;
      [zoom>=15] { line-width: 2; }
    }
  }    
  ['mapnik::geometry_type'=3] {
    polygon-fill: @land * 0.96;
    [type='apron'] {
      polygon-fill: @land * 0.98;  
    }  
  }
}

