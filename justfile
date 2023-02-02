# Autoload a .env if one exists
set dotenv-load

# export HARDHAT_NETWORK := env_var_or_default("HARDHAT_NETWORK", "localhost")

# This is the default tast
default:
  @just --list

# This is how to alias a task
# alias b := build

# Install dependencies
install:
  @forge install
# @forge install transmissions11/solmate
# @forge install Openzeppelin/openzeppelin-contracts
# @forge install OpenZeppelin/openzeppelin-contracts-upgradeable --no-commit

# Push to github
push:
  @forge test
  @forge fmt
  @forge snapshot
  @forge fmt --check
  @forge snapshot --check
  @git push

# Run forge unit tests in a fork environment while identifying contract names
test-fork:
  @forge test --fork-url $MAINNET_RPC_URL --etherscan-api-key $ETHERSCAN_API_KEY

# Create a contract
create contract="." :
  @forge create {{contract}} --rpc-url=$GOERLI_PRIVATE_KEY --private-key=$GOERLI_PRIVATE_KEY
# @forge create {{contract}} --rpc-url=$RPC_URL --private-key=$PRIVATE_KEY --constructor-args <name> <symbol>
# @forge create --rpc-url <your_rpc_url> --private-key <your_private_key> src/MyContract.sol:MyContract
# @forge create --rpc-url <your_rpc_url> --constructor-args "ForgeUSD" "FUSD" 18 1000000000000000000000 --private-key <your_private_key> src/MyToken.sol:MyToken --etherscan-api-key <your_etherscan_api_key> --verify

# send a transaction
send method="."  args="." args1="." args2="." args3="." args4=".":
  @cast send --rpc-url=$GOERLI_PRIVATE_KEY $TARGET_ADDRESS {{method}} {{args}} {{args1}} {{args2}} {{args3}} {{args4}} --private-key=$GOERLI_PRIVATE_KEY

# send a transaction
call method="."  args=".":
 @cast call --rpc-url=$GOERLI_PRIVATE_KEY $TARGET_ADDRESS {{method}} {{args}}

# Run forge unit tests
# test contract="." test="." *flags="":
#	 Using date here to give some randomness to tests that use block.timestamp
#	 @forge test --allow-failure --block-timestamp `date '+%s'` --match-contract {{contract}} --match-test {{test}} {{flags}}

debug file="."  method="." args="." args1=".":
 @forge debug --debug {{file}} --sig {{method}} {{args}} {{args1}}
# forge debug --debug src/SomeContract.sol --sig "myFunc(uint256,string)" 123 "hello"
# forge test --debug "testSomething()"
