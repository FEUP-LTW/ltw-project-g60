<div class="content">
    <section id="pet_edit">
        <section id="left" style="background-image: url('database/images/defaults/addDog.jpg')">
            <h2>Edit the details about your pet!</h2>
        </section>
        <section id="right">
            <form id="pet_add_form" action="action_editpet.php" method="post" enctype="multipart/form-data" autocomplete="off" onsubmit='verify(<?= json_encode( $breeds ) ?>, <?= json_encode( $colors ) ?>);'>
                <label>Name
                    <input type="text" name="name" placeholder="Pet's name" value="<?= $pet['name'] ?>" required>
                </label>
                <label>Breed
                    <div class="autocomplete">
                        <input id="breed_input"  type="text" name="breed" value="<?= $pet['species'] ?>" placeholder="Pet's breed" required>
                    </div>
                    <script>
                        autocomplete(document.getElementById("breed_input"), <?= json_encode( $breeds )?>);
                    </script>
                </label>
                <label>Size
                    <input type="number" name="size" placeholder="Pet's size" value="<?= $pet['size'] ?>" step=".01" min="0" required>
                </label>
                <label>Color
                    <div class="autocomplete" >
                        <input id="color_input" type="text" name="color" value="<?= $pet['color'] ?>" placeholder="Pet's color" required>
                    </div>
                    <script>
                        autocomplete(document.getElementById("color_input"), <?= json_encode( $colors )?>);
                    </script>
                </label>
                <label>Age
                    <input type="number" name="age" value="<?= $pet['age'] ?>" placeholder="Pet's age" min="0" required>
                </label>
                <label>Location
                    <input type="text" name="location" value="<?= $pet['location'] ?>" placeholder="Pet's location" required>
                </label>
                <div id="gender-option">
                    <label>Male
                        <input type="radio"  name="gender" value="0" <?php if ($pet['gender'] == 0) echo 'checked="checked"'?>>
                        <span class="checkmark"></span>
                    </label>
                    <label>Female
                        <input type="radio"  name="gender" value="1" <?php if ($pet['gender'] == 1) echo 'checked="checked"'?>>
                        <span class="checkmark"></span>
                    </label>
                </div>
                <label>Information
                    <textarea id="petInfo" name="information" placeholder="Pet's info"><?= $pet['info'] ?></textarea>
                </label>
                <select name="status" required>
                    <option value="" disabled selected>Status</option>
                    <option value="prepared">prepared</option>
                </select>
                <label>
                    <span class="material-icons">
                    add_photo_alternate
                    </span>
                    Choose photo
                    <input hidden type="file" name="photo" required>
                </label>
                <label>
                    Add Pet!
                    <input hidden type="submit" class="button">
                </label>
            </form>
        </section>
    </section>
</div>