%% Taken from Octave's communication package. The only modifications
%% to the original file after this line are for Matlab compatibility.

%% Copyright (C) 2008 Sylvain Pelissier <sylvain.pelissier@gmail.com>
%%
%% This program is free software; you can redistribute it and/or modify it under
%% the terms of the GNU General Public License as published by the Free Software
%% Foundation; either version 3 of the License, or (at your option) any later
%% version.
%%
%% This program is distributed in the hope that it will be useful, but WITHOUT
%% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
%% FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
%% details.
%%
%% You should have received a copy of the GNU General Public License along with
%% this program; if not, see <http://www.gnu.org/licenses/>.

%% -*- texinfo -*-
%% @deftypefn {Function File} {@var{intrlvd} =} intrlv (@var{data}, @var{elements})
%% Interleaved elements of @var{data} according to @var{elements}.
%% @seealso{deintrlv}
%% @end deftypefn

function intrlvd = intrlv (data, elements)

  if (nargin ~= 2)
    print_usage ();
  end

  if (~isvector (elements))
    error ('intrlv: ELEMENTS must be a vector');
  end

  if (isvector (data))
    if (length (elements) ~= length (data) || any (sort (elements) ~= 1:length (data)))
      error ('intrlv: ELEMENTS must be a permutation of DATA indices');
    end
    intrlvd = data(elements);
  else
    if (length (elements) ~= size (data, 1) || any (sort (elements) ~= 1:size (data, 1)))
      error ('intrlv: ELEMENTS must be a permutation of DATA indices');
    end
    intrlvd = data(elements,:);
  end

end

%% Test input validation
%!error intrlv ()
%!error intrlv (1)
%!error intrlv (1, 2, 3)
