#clc
clear -classes
clear all

x = example_class([0 9 7])
#methods(x)
x.get_dot_coords()


disp("set")
x = set_dot_coords(x, [2 4 8]);
x.get_dot_coords()

disp("array of class instance")
x.class_array(2)


y = sin(x*2)
disp("array element of result")
y.class_array(2)
2*x


%{
disp("directly") #only with public access properties
x.class_array = [2 4 8];

x.class_array #only with public access properties
%}



# default initialization test
%!test
% !x = example_class()
% !assert (isequal (x.get_dot_coords(),  [0, 1, 2]))


# initialization with parameters test
%!test
% !x = example_class(3, 4, [0 9 7])
% !assert (isequal (x.get_dot_coords(), [0 9 7]))

# set function test
%!test
% !x = example_class(3, 4, [0 9 7])
% x = set_dot_coords(x, [2 4 8]);
% !assert (isequal (x.get_dot_coords(), [2 4 8]))

# mtimes function test

%!test
% !x = example_class(3, 4, [0 9 7])
% x*2
% !assert (isequal (x.get_dot_coords(), [0 18 14]))

%!test
% !x = example_class(3, 4, [0 9 7])
% 3*x
% !assert (isequal (x.get_dot_coords(), [0 27 21]))
