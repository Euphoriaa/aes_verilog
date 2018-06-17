@set filename=aes_cipher
@set tb=%filename%
@set iverilog=%tb%.v
@set vvp=%tb%.vvp
@set gtkwave=%filename%.vcp

@iverilog %iverilog% -o %vvp%
@vvp %vvp%
@rem gtkwave %gtkwave%