# INTRINSIC FUNCTION REFERENCE 

UR: https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/intrinsic-function-reference.html


-ImageId: pick the id from the ec2 instance launching after the word type of the instance name

-  !Join is an instrinsic function used to name instances with a delimiter
# EX !Join ["-", [first, second, third]] => Will name the instance as first-second-third

# CHANGE SET 
# Basically what change set does is to allow modification to created stacks 
# when making a change to an ami check the replacement to see if true or not and if ok with it go ahead.


# MORE INTRISIC FUNCITONS  FILE </> create-security-group-ec2-instance.yaml
# REF making reference to an existing resource while creatin another 


# SecurityGroupIngress => in Bound rules
# SecurityGroupEgress =>  out Bound rules 


# MAPPINGS AND PSEUDOPARAMETERS 