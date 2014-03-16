%% Taken from Octave's signal package. The only modifications
%% to the original file after this line are for Matlab compatibility.

%% Copyright (C) 2001 Paul Kienzle <pkienzle@users.sf.net>
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
%% @deftypefn  {Function File} {} dct (@var{x})
%% @deftypefnx {Function File} {} dct (@var{x}, @var{n})
%% Compute the discrete cosine transform of @var{x}.  If @var{n} is given,
%% then @var{x} is padded or trimmed to length @var{n} before computing the
%% transform.  If @var{x} is a matrix, compute the transform along the columns
%% of the the matrix.  The transform is faster if @var{x} is real-valued and
%% has even length.
%%
%% The discrete cosine transform @var{x} can be defined as follows:
%%
%% @example
%% @group
%%               N-1
%%   X[k] = w(k) sum x[n] cos (pi (2n+1) k / 2N ),  k = 0, ..., N-1
%%               n=0
%% @end group
%% @end example
%%
%% with w(0) = sqrt(1/N) and w(k) = sqrt(2/N), k = 1, ..., N-1.  There
%% are other definitions with different scaling of X[k], but this form
%% is common in image processing.
%%
%% @seealso{idct, dct2, idct2, dctmtx}
%% @end deftypefn

%% From Discrete Cosine Transform notes by Brian Evans at UT Austin,
%% http://www.ece.utexas.edu/~bevans/courses/ee381k/lectures/09_DCT/lecture9/
%% the discrete cosine transform of x at k is as follows:
%%
%%          N-1
%%   X[k] = sum 2 x[n] cos (pi (2n+1) k / 2N )
%%          n=0
%%
%% which can be computed using:
%%
%%   y = [ x ; flipud (x) ]
%%   Y = fft(y)
%%   X = exp( -j pi [0:N-1] / 2N ) .* Y
%%
%% or for real, even length x
%%
%%   y = [ even(x) ; flipud(odd(x)) ]
%%   Y = fft(y)
%%   X = 2 real { exp( -j pi [0:N-1] / 2N ) .* Y }
%%
%% Scaling the result by w(k)/2 will give us the desired output.

function y = dct (x, n)

  if (nargin < 1 || nargin > 2)
    print_usage;
  end

  realx = isreal(x);
  [rowsx, colsx] = size(x);
  transpose = (rowsx == 1);

  if transpose
    x = x (:);
  end
  
  [nr, nc] = size (x);
  if nargin == 1
    n = nr;
  elseif n > nr
    x = [ x ; zeros(n-nr,nc) ];
  elseif n < nr
    x (nr-n+1 : n, :) = [];
  end

  if n == 1
    w = 1/2;
  else
    w = [ sqrt(1/4/n); sqrt(1/2/n)*exp((-1i*pi/2/n)*[1:n-1]') ] * ones (1, nc);
  end
  if ( realx && rem (n, 2) == 0 )
    y = fft ([ x(1:2:n,:) ; x(n:-2:1,:) ]);
    y = 2 * real( w .* y );
  else
    y = fft ([ x ; flipud(x) ]);
    y = w .* y (1:n, :);
    if (realx) y = real (y); end
  end
  if transpose
    y = y.';
  end

end
