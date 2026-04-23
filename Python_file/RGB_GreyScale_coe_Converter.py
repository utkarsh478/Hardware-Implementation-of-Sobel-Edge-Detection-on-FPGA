import cv2
import numpy as np

# =========================
# CONFIGURATION
# =========================
INPUT_IMAGE = INPUT_IMAGE = r"C:\Users\utkarsh\Desktop\UT\DSD_Project\Hardware-Implementation-of-Sobel-Edge-Detection-on-FPGA\Python_file\test_images.jpg"     # your image path
OUTPUT_COE = "fpga_image.coe"
SIZE = (256, 256)            # FPGA-friendly size

# =========================
# STEP 1: LOAD IMAGE
# =========================
img = cv2.imread(INPUT_IMAGE)

if img is None:
    print("Error: Image not found!")
    exit()

# =========================
# STEP 2: CONVERT TO GRAYSCALE
# =========================
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# =========================
# STEP 3: RESIZE IMAGE
# =========================
gray_resized = cv2.resize(gray, SIZE)

# =========================
# STEP 4: DISPLAY (OPTIONAL)
# =========================
cv2.imshow("Grayscale Image", gray_resized)
cv2.waitKey(0)
cv2.destroyAllWindows()

# =========================
# STEP 5: GENERATE .COE FILE
# =========================
with open(OUTPUT_COE, "w") as f:
    f.write("memory_initialization_radix=10;\n")
    f.write("memory_initialization_vector=\n")

    flat_pixels = gray_resized.flatten()

    for i, pixel in enumerate(flat_pixels):
        if i == len(flat_pixels) - 1:
            f.write(f"{int(pixel)};")
        else:
            f.write(f"{int(pixel)},\n")

print("✅ COE file generated successfully!")