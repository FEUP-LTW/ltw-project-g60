<?php
include_once('connection.php');
  // Insert image data into database
function uploadImage($image, $id, $path)
{
  // Generate filenames for original, small and medium files
  $originalFileName = "database/$path/originals/$id.jpg";
  $smallFileName = "database/$path/thumbs_small/$id.jpg";
  $mediumFileName = "database/$path/thumbs_medium/$id.jpg";

  chdir('..');
  $destination_path = getcwd().DIRECTORY_SEPARATOR;
  // Move the uploaded file to its final destination
  move_uploaded_file($image['tmp_name'],$destination_path . $originalFileName);

  // Crete an image representation of the original image
  $original = imagecreatefromjpeg($originalFileName);

  $width = imagesx($original);     // width of the original image
  $height = imagesy($original);    // height of the original image
  $square = min($width, $height);  // size length of the maximum square

  // Create and save a small square thumbnail
  $small = imagecreatetruecolor(200, 200);
  imagecopyresized($small, $original, 0, 0, ($width > $square) ? ($width - $square) / 2 : 0, ($height > $square) ? ($height - $square) / 2 : 0, 200, 200, $square, $square);
  imagejpeg($small, $smallFileName);

  // Calculate width and height of medium sized image (max width: 400)
  $mediumwidth = $width;
  $mediumheight = $height;
  if ($mediumwidth > 400) {
    $mediumwidth = 400;
    $mediumheight = $mediumheight * ($mediumwidth / $width);
  }

  // Create and save a medium image
  $medium = imagecreatetruecolor($mediumwidth, $mediumheight);
  imagecopyresized($medium, $original, 0, 0, 0, 0, $mediumwidth, $mediumheight, $width, $height);
  imagejpeg($medium, $mediumFileName);

  return $id;
}

?>
