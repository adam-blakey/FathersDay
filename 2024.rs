// Nice macro for creating Vec Strings.
//  From: https://stackoverflow.com/a/38183903
macro_rules! vec_str {
  ($($x:expr),*) => (vec![$($x.to_string()),*]);
}

fn main() {
  let mut names: Vec<String> = vec_str!["Adam", "Ben", "Lauren"];
  let mut success: Vec<bool> = vec![false; names.len()];

  for i in 0..names.len() {
    (names[i], success[i]) = assess_business_success_with_an_ess(names[i].clone());
  }
  
  for i in 0..names.len() {
    if success[i] {
      println!("✅ {} is going to be successful.", names[i]);
    } else {
      println!("⚠️ {} might want to consider being more Adam.", names[i]);
    }
  }
}

// Playing around with ownership for no good reason at all.
fn assess_business_success_with_an_ess(name: String) -> (String, bool) {
  let mut success = false;
  // According to science, this is the only way to be successful.
  if name == "Adam" {
    success = true;
  }
  (name, success)
}