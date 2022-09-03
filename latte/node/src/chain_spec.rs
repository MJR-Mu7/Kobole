use ratara_runtime::{GenesisConfig};

pub type ChainSpec = sc_service::GenericChainSpec<GenesisConfig>;

pub fn kobole_config() -> Result<ChainSpec, String> {
	//let boot_nodes = vec![];
	ChainSpec::from_json_bytes(&include_bytes!("../../../res/live.json")[..])
}