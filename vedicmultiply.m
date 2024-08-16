% Function to multiply two numbers based on the Vedic system of mathematics.
function [c] = vedicmultiply(a,b)
    %While the two strings do not have the same number of digits, attach 0
    %to start of the relevant string.
    while strlength(a)~=strlength(b)
        if strlength(a)>strlength(b)
            b=strcat('0',b);
        else
            a=strcat('0',a);
        end
    end
    %maximum length of the ans string
    steps=strlength(a)+strlength(b);
    total_str='';
    %create zero string of the max possible length of the answer
    for x=1:steps
        total_str=[total_str '0'];
    end
    x=strlength(a);
    y=strlength(b);
    %iterate to do n multiplications (upto and including halfway),
    %where n is number of digits in a or b
    for z=0:strlength(a)-1
        %create smaller substrings to do multiplications on
        sub_a=a(x-z:x);
        sub_b=b(y-z:y);
        %initiialise subtotal to hold value of the current multiplication
        sub_total=0;
        %iterate through sub_a and get the current multiplication value.
        for i=0:strlength(sub_a)-1
            sub_total=sub_total+(str2double(sub_a(strlength(sub_a)-i)))*str2double(sub_b(i+1));
        end
        %get the value of the right most digit and the value to be carried
        dig=mod(sub_total,10);
        carryover=int2str((sub_total-dig)/10);
        %Iterate through total_str and insert the right most digit.
        %If digit + the current value in the current indexed position > 9,
        %carry the dig=1 over to next position on the left.
        left=0;
        while 1
            if (str2double(total_str(steps-left))+dig) > 9
                total_str(steps-left)=int2str(mod(str2double(total_str(steps-left))+dig,10));
                left=left+1;
                dig=1;
            else
                total_str(steps-left)=int2str(str2double(total_str(steps-left))+dig);
                break
            end
        end
        %index through each digit in the carry value.
        %If carry + the current value in the current indexed position > 9,
        %carry the 1 over to next position on the left.
        for left=1:strlength(carryover)
            if (str2double(total_str(steps-left))+str2double(carryover(strlength(carryover)-left+1))) > 9
                total_str(steps-left)=int2str(mod(str2double(total_str(steps-left))+str2double(carryover(strlength(carryover)-left+1)),10));
                total_str(steps-left-1)=int2str(str2double(total_str(steps-left-1))+1);
            else
                total_str(steps-left)=int2str(str2double(total_str(steps-left))+str2double(carryover(strlength(carryover)-left+1)));
            end
        end
        steps=steps-1;
    end
    %Repeat same procedure as previous for loop; however,
    %this time carry out the 2nd half of the required multiplications
    for z=1:strlength(a)-1
        sub_a=a(1:x-z);
        sub_b=b(1:y-z);
        sub_total=0;
        for i=0:strlength(sub_a)-1
            sub_total=sub_total+(str2double(sub_a(strlength(sub_a)-i)))*str2double(sub_b(i+1));
        end
        dig=mod(sub_total,10);
        carryover=int2str((sub_total-dig)/10);
        left=0;
        while 1
            if (str2double(total_str(steps-left))+dig) > 9
                total_str(steps-left)=int2str(mod(str2double(total_str(steps-left))+dig,10));
                left=left+1;
                dig=1;
            else
                total_str(steps-left)=int2str(str2double(total_str(steps-left))+dig);
                break
            end
        end
        for left=1:strlength(carryover)
            if (str2double(total_str(steps-left))+str2double(carryover(strlength(carryover)-left+1))) > 9
                total_str(steps-left)=int2str(mod(str2double(total_str(steps-left))+str2double(carryover(strlength(carryover)-left+1)),10));
                total_str(steps-left-1)=int2str(str2double(total_str(steps-left-1))+1);
            else
                total_str(steps-left)=int2str(str2double(total_str(steps-left))+str2double(carryover(strlength(carryover)-left+1)));
            end
        end
        steps=steps-1;
    end
    %strip leading zeros from total value of a*b
    c=strip(total_str,'left','0');
end