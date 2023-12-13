library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity forc is
	 Port ( clk           : in  STD_LOGIC;
           reset         : in  STD_LOGIC;
           user_input    : in  STD_LOGIC_VECTOR(3 downto 0);
			  
           lives_out     : out STD_LOGIC_VECTOR(1 downto 0);
           game_over     : out STD_LOGIC;
			  victory       : out STD_LOGIC
			);
end forc;

architecture Behavioral of forc is

    constant secret_number1 : STD_LOGIC_VECTOR(3 downto 0) := "0111";
	 constant secret_number2 : STD_LOGIC_VECTOR(3 downto 0) := "0001";
	 constant secret_number3 : STD_LOGIC_VECTOR(3 downto 0) := "0100";
	 constant secret_number4 : STD_LOGIC_VECTOR(3 downto 0) := "0101";
	 constant secret_number5 : STD_LOGIC_VECTOR(3 downto 0) := "0000";
	 
	 constant value_1HZ_c : integer := 500000000;
	 signal   cnt_s       : integer   := 0;
	 signal   clk_1s      : std_logic := '0';
	 
	 signal   discovered1 : std_logic := '0';
	 signal   discovered2 : std_logic := '0';
	 signal   discovered3 : std_logic := '0';
	 signal   discovered4 : std_logic := '0';
	 signal   discovered5 : std_logic := '0';
	 
	 signal   lives     : integer  := 3;
	 signal   go        : std_logic := '0';
	 signal   win       : std_logic := '0';

begin

process(clk)
begin
	if clk'event and clk = '1' then
		if cnt_s = value_1HZ_c - 1 then
			cnt_s <= 0;
			clk_1s <= '1';
		else
			cnt_s <= cnt_s + 1;
			clk_1s <= '0';
		end if;
	end if;
end process;

process(clk_1s, reset)
    begin
        if reset = '1' then
				discovered1 <= '0';
				discovered2 <= '0';
				discovered3 <= '0';
				discovered4 <= '0';
				discovered5 <= '0';
				go <= '0';
				win <= '0';
				lives <= 3;
				
        elsif clk_1s'event and clk_1s = '1' then
            if discovered1 = '0' and user_input = secret_number1 then
                discovered1 <= '1';
					 go <= '0';
					 win <= '0';
            elsif discovered2 = '0' and user_input = secret_number2 then
					discovered2 <= '1';
					go <= '0';
					win <= '0';					
				elsif discovered3 = '0' and user_input = secret_number3 then
					discovered3 <= '1';
					go <= '0';
					win <= '0';
				elsif discovered4 = '0' and user_input = secret_number4 then
					discovered4 <= '1';
					go <= '0';
					win <= '0';
				elsif discovered5 = '0' and user_input = secret_number5 then
					discovered5 <= '1';
					go <= '0';
					win <= '0';
				elsif discovered1 = '1' and discovered2 = '1' and discovered3 = '1' and discovered4 = '1' and discovered5 = '1' then
					win <= '1';
					go <= '0';
            else
					if lives = 3 then
						lives <= lives - 1;
						go <= '0';
						win <= '0';
					elsif lives = 2 then
						lives <= lives - 1;
						go <= '0';
						win <= '0';
					else
						lives <= lives - 1;
						go <= '1';
						win <= '0';
					end if;
				end if;
        end if;
		  
		  lives_out <= std_logic_vector(to_unsigned(lives , lives_out'length));
		  game_over <= go;
	     victory <= win;
    end process;

end Behavioral; 
