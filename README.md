## Ethernaut Solutions (Web3 Security)# Ethernaut Solutions — Web3 Security

Solutions to the [Ethernaut CTF](https://ethernaut.openzeppelin.com/) by OpenZeppelin — a hands-on platform for learning smart contract security through real vulnerabilities.

---

## About

Ethernaut is a war game that teaches Ethereum smart contract security through practical challenges.

This repository documents:

- Solutions to each level using Foundry
- Exploit scripts with documented methodology
- Vulnerability breakdowns from first principles
- Real-world attack patterns and their implications

---

## Tech Stack

- Solidity
- Foundry (Forge)
- EVM (Opcodes, Storage, Memory)
- Git & GitHub

---

## Project Structure
```
├── src/        # Challenge contracts
├── script/     # Exploit scripts (Foundry)
├── lib/        # Dependencies (forge-std, OpenZeppelin)
├── foundry.toml
└── README.md
```

---

## How to Run
```bash
forge build

forge script script/<LevelSolution>.s.sol \
  --rpc-url <RPC_URL> \
  --private-key <PRIVATE_KEY> \
  --broadcast \
  --tc <ContractName> -vvvv
```

---

## Disclaimer

This repository is for educational purposes only. All exploits are performed on CTF environments.

---

## Connect

Open to conversations on Web3 security, smart contract auditing, and CTFs.

If you find this useful, consider starring the repository.


