# pintswap-staking

This repo contains sources for PintSwap asset staking contracts, including sipERC20 single-sided staking for altcoins, as well as for PINT itself.

## sPINT

The PINT staking framework uses a revenue model which is driven by minting inefficient LP, weighted in favor of the ETH side. The sPINT staking token is an ERC4626 vault which takes PINT/ETH LP as an input to mint. Trades on PINT incur a small tax which is used to mint LP directly to the sPINT vault, but instead of minting LP at fair value, the low-level UniswapV2Pair API is used to supply extra ETH with the mint transaction. When this occurs, less LP is minted than a normal mint operation, but the value of LP increases per ETH basis. The LP that results from the mint is transferred directly to the sPINT vault. By this mechanism, sPINT stakers receive the majority of upside from PINT trading.

Revenue from MEV bots holding an OPPS NFT, above the configurable threshold for revenue which remains within the sipERC20 vault for the given asset, is converted to PINT/ETH LP in a similar way at an inefficient ratio. In this way, PINT is able to capture value from trade activity across all markets.

## Author

The OPPS
