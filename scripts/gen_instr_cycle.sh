#! /bin/sh
#
# gen_instr_cycle.sh - generate instruction cycles based on template
#
# Arguments:
#   $1 - template for cycles generation
#   $2 - target file to store information
#   $3 - instruction the cycles are generated for
#   $4 - Should generate CPI != 1 (yes or no)

TEMPLATE=$1
TARGET=$2
INSN=$3
USE_CPI=$4
CYCLES=1

# Get cycles value from template
if [ -f "$TEMPLATE" ] && [ "$USE_CPI" = "yes" ];
then
    CYCLES=`grep -w $INSN $TEMPLATE | awk '{ printf $2 }'`
fi

# Safety measure, just in case new instructions aren't included in template
if [ -z "$CYCLES" ];
then
CYCLES=1
fi

printf 'CONSUME_CYCLES(%s);\n' $CYCLES > $TARGET
