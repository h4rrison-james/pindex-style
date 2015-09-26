// ---------------------------------------------------------------------
// Colours

// Base
@water: #ddeeff;
@land: #fffee5;
@line: #226688;
@building: #fae364;

// Land Use
@park: #aadb78;
@hospital: #fde;
@school: #f0e8f8;
@wood: #6a4;

// Testing
@f00: #f00;

#10m-900913-bounding-box::bottom[zoom<=8] {
    polygon-fill: @water;
}

#10m-900913-bounding-box::bottom[zoom>8] {
  polygon-fill: @land;
}

#water[zoom>8] {
  polygon-fill: @water;
}

// ---------------------------------------------------------------------
// Landuse areas 

#landuse [zoom>8] {
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
  polygon-fill: @building;
  polygon-opacity: 0.4;
  opacity: 0.5;
  [zoom>=17] {
    line-color: @building;
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

