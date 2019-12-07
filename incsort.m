function srt=incsort(toSort,varargin)
%%Sort but not by the each, increment datasets by first var.
pts=length(toSort); var=length(varargin);
srt=zeros(pts,var); srt(:,1)=toSort(:);
for n=[1:var]
    srt(:,n+1)=varargin{n};
end
for o=[1:pts]
    [smll,here]=min(srt(o:end,1));
    if srt(o,1)~=smll
        srt([o,here+(o-1)],:)=srt([here+(o-1),o],:);
    end
end