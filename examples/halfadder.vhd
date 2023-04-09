
entity halfadder is port (
    p, q : in bit;
    s, carry : out bit
    );
    attribute keep : string;
    attribute keep of s : signal is "true"; 
    attribute keep of carry : signal is "true"; 
end entity;

architecture a_halfadder of halfadder is
begin
    s <= p xor q;
    carry <= p and q;
end architecture;
