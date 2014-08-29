#!/bin/sh
perl -le '$user_number=shift;for($counter=2;$counter<=$user_number;$counter++){next if $user_number%$counter; $user_number=$user_number/$counter;print $counter; redo}' 12

