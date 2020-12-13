<div class="content">
    <section id="pet_add">
        <section id="left" style="background-image: url('database/images/defaults/addDog.jpg')">
            <h2>Give us the details about your pet!</h2>
        </section>
        <section id="right">
            <form action="action_addpet.php" method="post" enctype="multipart/form-data" autocomplete="off">
                <label>Name
                    <input type="text" name="name" placeholder="Pet's name" required>
                </label>
                <label>Breed
                    <input id="breed_input"  type="text" name="breed" placeholder="Pet's breed" required>
                    <script>
                        autocomplete(document.getElementById("breed_input"), <?= json_encode( $breeds )?>);
                    </script>
                </label>
                <label>Size
                    <input type="number" name="size" placeholder="Pet's size" step=".01" min="0" required>
                </label>
                <label>Color
                    <input id="color_input" type="text" name="color" placeholder="Pet's color" required>
                    <script>
                        autocomplete(document.getElementById("color_input"), <?= json_encode( $colors )?>);
                    </script>
                </label>
                <label>Age
                    <input type="number" name="age" placeholder="Pet's age" min="0" required>
                </label>
                <label>Location
                    <input type="text" name="location" placeholder="Pet's location" required>
                </label>
                <div id="gender-option">
                    <label>Male
                        <input type="radio"  name="gender" value="male" checked="checked">
                        <span class="checkmark"></span>
                    </label>
                    <label>Female
                        <input type="radio"  name="gender" value="female">
                        <span class="checkmark"></span>
                    </label>
                </div>
                <label>Information
                    <textarea id="petInfo" name="information" placeholder="Pet's info"></textarea>
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