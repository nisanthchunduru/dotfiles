functions_dir="${${(%):-%N}:A:h}/functions"

for function_file in "$functions_dir"/*(N); do
  [[ "$function_file" == *.disabled ]] && continue
  source "$function_file"
done

unset functions_dir function_file
