module tbot(clock, m1_en, reset, m1_dir, m1_led, m1_stepperPins, m2_en, m2_dir, m2_led, m2_stepperPins, machine_on, sig, led);

input clock, reset;
input m1_dir, m2_dir, m1_en, m2_en;

output [2:0] m1_led;
output [2:0] m2_led;

//output to the motors
output [3:0] m1_stepperPins;
output [3:0] m2_stepperPins;

//signal to the machine and indicator
input machine_on;
output sig, led;

//motor 1
stepper s1(.clock(clock),
				.en(m1_en),
				.reset(reset),
				.dir(m1_dir),
				.led(m1_led),
				.stepperPins(m1_stepperPins));

				
//motor 2
stepper s2(.clock(clock),
				.en(m2_en),
				.reset(reset),
				.dir(m2_dir),
				.led(m2_led),
				.stepperPins(m2_stepperPins));

//


signal signal(.clk(clock),
					.en(machine_on),
					.signal(sig),
					.led(led));


endmodule

