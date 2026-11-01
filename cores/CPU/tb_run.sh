NC='\033[0m'

echo 'Running test FETCH module'
iverilog tb/fetch_tb.v -o tb/_fetch_tb.o && vvp tb/_fetch_tb.o
echo -e "${GREEN}DONE!${NC}"
iverilog rtl/fetch.v tb/fetch_tb.v -o tb/_fetch_tb.o && vvp tb/_fetch_tb.o && echo -e "${GREEN}DONE!${NC}"