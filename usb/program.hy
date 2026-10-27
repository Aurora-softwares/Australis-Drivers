public class DriverMain {
	public static int Run(long context) {
		if (context < 4096) { return 1; }
		// The xHCI controller is still owned by the built-in kernel driver.
		// Check its mapped capability register before accepting this module.
		long mmio = System.Kernel.Memory.Read64(context + 2368);
		if (mmio == 0) { return 0; }
		long capability = System.Kernel.Memory.Read32(mmio);
		if (capability == 0 || capability == 4294967295) { return 2; }
		return 0;
	}
}
