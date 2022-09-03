//! A set of constant values used in substrate runtime.

/// Money matters.
pub mod currency {
	use node_primitives::Balance;

	pub const MILLICENTS: Balance = 1_000_000_000;
	pub const CENTS: Balance = 1_000 * MILLICENTS; // assume this is worth about a cent.
	pub const KOBOLE: Balance = 100 * CENTS;

	// Unit = the base number of indivisible units for balances
	pub const UNIT: Balance = 100_000_000;
	pub const MILLIUNIT: Balance = UNIT / 1000;
	pub const MICROUNIT: Balance = MILLIUNIT / 1000;
	
	/// The existential deposit. Set to 1/10 of the Connected Relay Chain.
	pub const EXISTENTIAL_DEPOSIT: Balance = 1;
	
	pub const fn deposit(items: u32, bytes: u32) -> Balance {
		items as Balance * 15 * CENTS + (bytes as Balance) * 6 * CENTS
	}
}
