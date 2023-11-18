# Robotic-Arm-Control
In this repository, you will find all the necessary that you need to create a program with Processing and Arduino. In this repository there is:
1. Arduino folder: it si the program 
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
