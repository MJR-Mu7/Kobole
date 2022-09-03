use substrate_build_script_utils::{generate_cargo_keys, rerun_if_git_head_changed};

fn main() {
	generate_cargo_keys();

	rerun_if_git_head_changed();

	if cfg!(target_os = "windows,linux,macos,android,fuschia,ios,tvos,wasi") {
		let mut res = winres::WindowsResource::new();
		res.set_icon("kobole.ico"); // Replace this with the filename of your .ico file.
		res.compile().unwrap();
	}
}