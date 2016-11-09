function [result, index] = searchforType(type, graph) 
    
    index = [];
    result = [];
    n = 1;
    for k = 1:length(graph)
        if any(ismember(graph{k}.('x_type'), type)) && isa(graph{k}.('x_type'), 'cell')
            result{n} = graph{k};
            index{n} = k;
            n = n+1;
        end
        if isa(graph{k}.('x_type'), 'char')
            if strcmp(graph{k}.('x_type'), type)
                result{n} = graph{k};
                index{n} = k;
                n = n+1;
            end
        end
    end
end
