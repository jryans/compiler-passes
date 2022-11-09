set -eux

curl 'https://godbolt.org/api/compiler/cclang1300/compile' \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
--data-raw '{"source":"int example(int num) {\n  return num * num;\n}\n","compiler":"cclang1300","options":{"userArguments":"-fno-discard-value-names -O0","compilerOptions":{"produceLLVMOptPipeline":{"filterDebugInfo":true,"filterIRMetadata":true,"fullModule":false,"noDiscardValueNames":true,"demangle":true}},"filters":{"binary":false,"execute":false,"intel":true,"demangle":true,"labels":false,"libraryCode":true,"directives":false,"commentOnly":false,"trim":false}},"lang":"c","allowStoreCodeDebug":true}' \
| \
jq -r '.llvmOptPipelineOutput.results.example | .[] | .name' \
> \
O0.md

curl 'https://godbolt.org/api/compiler/cclang1300/compile' \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
--data-raw '{"source":"int example(int num) {\n  return num * num;\n}\n","compiler":"cclang1300","options":{"userArguments":"-fno-discard-value-names -O1","compilerOptions":{"produceLLVMOptPipeline":{"filterDebugInfo":true,"filterIRMetadata":true,"fullModule":false,"noDiscardValueNames":true,"demangle":true}},"filters":{"binary":false,"execute":false,"intel":true,"demangle":true,"labels":false,"libraryCode":true,"directives":false,"commentOnly":false,"trim":false}},"lang":"c","allowStoreCodeDebug":true}' \
| \
jq -r '.llvmOptPipelineOutput.results.example | .[] | .name' \
> \
O1.md

curl 'https://godbolt.org/api/compiler/cclang1300/compile' \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
--data-raw '{"source":"int example(int num) {\n  return num * num;\n}\n","compiler":"cclang1300","options":{"userArguments":"-fno-discard-value-names -O2","compilerOptions":{"produceLLVMOptPipeline":{"filterDebugInfo":true,"filterIRMetadata":true,"fullModule":false,"noDiscardValueNames":true,"demangle":true}},"filters":{"binary":false,"execute":false,"intel":true,"demangle":true,"labels":false,"libraryCode":true,"directives":false,"commentOnly":false,"trim":false}},"lang":"c","allowStoreCodeDebug":true}' \
| \
jq -r '.llvmOptPipelineOutput.results.example | .[] | .name' \
> \
O2.md

curl 'https://godbolt.org/api/compiler/cclang1300/compile' \
-X POST \
-H 'Accept: application/json' \
-H 'Content-Type: application/json' \
--data-raw '{"source":"int example(int num) {\n  return num * num;\n}\n","compiler":"cclang1300","options":{"userArguments":"-fno-discard-value-names -O3","compilerOptions":{"produceLLVMOptPipeline":{"filterDebugInfo":true,"filterIRMetadata":true,"fullModule":false,"noDiscardValueNames":true,"demangle":true}},"filters":{"binary":false,"execute":false,"intel":true,"demangle":true,"labels":false,"libraryCode":true,"directives":false,"commentOnly":false,"trim":false}},"lang":"c","allowStoreCodeDebug":true}' \
| \
jq -r '.llvmOptPipelineOutput.results.example | .[] | .name' \
> \
O3.md

set +e
git diff --no-index -U0 O0.md O1.md > 'O0 to O1.diff'
git diff --no-index -U0 O1.md O2.md > 'O1 to O2.diff'
git diff --no-index -U0 O2.md O3.md > 'O2 to O3.diff'
set -e
