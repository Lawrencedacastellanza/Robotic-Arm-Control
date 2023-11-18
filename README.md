# Robotics Arm Control with Processing and Arduino

This repository provides all the necessary resources for creating programs using Processing and Arduino to control a robotic arm. The repository includes the following folders:
1. **Arduino**: Contains the Arduino program that is compatible with all the Processing programs in this repository.
2. **Processing Mouse**: This folder contains a simple Processing program enabling an initial interaction with the connection between Processing, Arduino, and the robotic arm. The program allows you to control the arm's servos using the mouse wheel, employing relative angles.
3. **Processing Slider**: Running the program in this folder displays an image of the 6-degree robotic arm with implemented knobs for each servo. This program aids in gaining familiarity with the knobs, facilitating control of the robotic arm using absolute angles.
4. **Processing 3D**: This folder houses a more complex version of the program. It creates a 3D representation of the robotic arm in Processing, replicating the same movements as the physical robot connected to your Arduino Board.

The following sections provide detailed information about each program.
## General prerequisites
- Arduino IDE installed on your computer.
- 6DoF Robotics arm: I have used this [one](https://www.amazon.it/Taidda-Manipolatore-Industriale-insegnamento-Universitario/dp/B084FSVQYC/ref=asc_df_B084FSVQYC/?tag=googshopit-21&linkCode=df0&hvadid=459268327566&hvpos=&hvnetw=g&hvrand=11317279051347235925&hvpone=&hvptwo=&hvqmt=&hvdev=c&hvdvcmdl=&hvlocint=&hvlocphy=20569&hvtargid=pla-1001227747582&psc=1&mcid=f9a52a06b82c34429ae7a00b076da8ab) but I have to say that I have found a lot of problem with the servos. I suggest you to by a more expensive one that will last longer and will have a better construction quality. 
# Arduino ServoEasing Control

This Arduino sketch allows you to control up to 6 servo motors with easing functions using the ServoEasing library. The code is designed to receive commands through the serial monitor to switch between servos, set absolute angles, and move servos in relative angles.

## Prerequisites

- Arduino IDE installed on your computer.
- ServoEasing library installed. You can find it [here](https://www.arduino.cc/reference/en/libraries/servoeasing/).

## Configuration

1. **Servo Configuration**: Modify the servo attachment settings in the `setup` function to match your servo connections.

    ```cpp
    Servo0.attach(11, 90, 600, 2400, 0, 180);
    Servo1.attach( /* your_pin */ , 90, 600, 2400, 0, 180);
    Servo2.attach(9, 90, 600, 2400, 0, 180);
    // ... (repeat for Servo3 to Servo5)
    ```

    Ensure that you replace `/* your_pin */` with the actual pin number for `Servo1`.

2. **Easing Configuration**: Choose the easing functions you want to enable by uncommenting the corresponding `#define` statements in the beginning of the code.

    ```cpp
    #define ENABLE_EASE_QUADRATIC
    // Uncomment others as needed
    ```

3. **Initial Setup**: Set the maximum number of servo objects and other parameters.

    ```cpp
    #define MAX_EASING_SERVOS 6
    short unsigned int vel = 50;
    ```

    Adjust `MAX_EASING_SERVOS` based on the number of servo motors you are using.

## Usage

1. Upload the code to your Arduino board.

2. Open the serial monitor in the Arduino IDE.

3. Send commands to control the servos:
   - `k` followed by a number (1 to 6): Switch to the specified servo.
   - `a` followed by a number: Move the selected servo to the requested absolute angle.
   - `r` followed by a number: Move the selected servo in a relative angle.

## Serial Commands

- `k`: Switch servo.
- `a`: Set absolute angle for the selected servo.
- `r`: Move the selected servo in a relative angle.

## Example

1. To switch to Servo 3: Send `k3`.
2. To set Servo 1 to angle 45 degrees: Send `a45`.
3. To move Servo 2 by +10 degrees: Send `r10`.

Feel free to modify the code to suit your specific requirements.
