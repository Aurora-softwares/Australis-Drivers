public class DriverMain {
	public static int Run(long context) {
		if (context < 4096) { return 1; }
		if (System.Kernel.Memory.Read32(context) != 2 ||
			System.Kernel.Memory.Read32(context + 4) != 1 ||
			System.Kernel.Memory.Read32(context + 64) != 1) { return 2; }
		long mmio = System.Kernel.Memory.Read64(context + 32);
		long length = System.Kernel.Memory.Read64(context + 40);
		if (mmio < 4096 || length < 4096) { return 3; }
		int capabilityLength = System.Kernel.Memory.Read32(mmio) % 256;
		if (capabilityLength < 32 || capabilityLength > 252) { return 4; }
		System.Kernel.Memory.Write32(context + 72, capabilityLength);
		return 0;
	}
}
