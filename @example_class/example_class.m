classdef example_class
  #---properties (getAccess = 'public', SetAccess = 'private')---
    #in this case we can get values of properties via x.property_name,
    #but can't use set_dot_coords function wuth public access to change property value
    #if try rise an error "error: subsasgn: property 'property_name' has private access and cannot be set in this context"

  #properties (Access = 'private')
    #in  this case we can't get values of properties via x.property_name,
    #if try rise an error "error: subsref: property 'property_name' has private access and cannot be obtained in this context"
    #but we can use getters like get_dot_coords function with public access to get properties value
    #we can also change property value using set_dot_coords function with public access and get no errors

  properties (Access = 'public')#---
    #in  this case we can get values of properties via x.property_name,
    #we can also change property value directly like x.property_name = new_value;
    #without errors
    class_array;
  endproperties

  methods (Access = 'public')

    function obj = example_class(class_array = [0, 1, 2])
      obj.class_array = class_array;
    endfunction

    function disp(obj)
        disp('Class array: ');
        obj.class_array
    endfunction


  function obj = set_dot_coords(obj, val)
  #function out = set_dot_coords(obj, val)

      disp("set here!")
      #out = obj;

      # MWE (no errors)
      #out.class_array = val;
      obj.class_array = val;

      %{
      # approach 2 error : property 'class_array' has private access and cannot be set in this context
      idx.type = ".";
      idx.subs = "class_array"
      obj = subsasgn(obj, idx, val);
      %}

      disp("set result")
      obj.class_array
      disp("set result end")

  endfunction

  function obj = mtimes(obj, g)
    % example_class * double
    objIsExampleClass = isa(obj, 'example_class');
    disp(objIsExampleClass)
    gIsExampleClass = isa(g, 'example_class');
    disp(gIsExampleClass)

    if ( objIsExampleClass && isnumeric(g) )      % Example_class * double
      obj = times(obj, g);
    endif
    if ( isnumeric(obj) && gIsExampleClass )       % double * Example_class
      obj = mtimes(g, obj);
    endif
  endfunction

  function obj = times(obj, g)
    if ( isnumeric(g) )       % Example_class * double

      if ( numel(obj) == 1 )

          obj.class_array = obj.class_array .* g;
      endif
    endif
  endfunction



    function obj = subsasgn(obj, index, val)
      idx = index(1).subs;
      # debugging:
      disp("we're in subsasgn...")
      index
      idx
      val
      switch index(1).type
          case '.'

              % [TODO]: Restrict access to this.
              obj = builtin('subsasgn', obj, index, val);
              #!!! ERROR :  subsasgn: property 'class_array' has private access and cannot be set in this context
      end
    end

    function F = sin(F, varargin)

      F.class_array = sin(F.class_array)

    end


    function res = get_dot_coords(obj)
      disp("get here!")
      res = obj.class_array;
    endfunction

  endmethods
endclassdef
