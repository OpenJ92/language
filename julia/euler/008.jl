function Complex_Pythag(α::Complex{Int})::Tuple{Int, Int, Any}
	ζ = α * α
	return (real(ζ), imag(ζ), round(Int, abs(ζ)))
end

function 𝕧_Complex_Pythag(α, β, ζ)::Bool
	return α^2 + β^2 - ζ^2 == 0
end

m = [Complex_Pythag(complex(α...)) for α ∈ [(j, i) for i ∈ [1:100;] for j ∈ [i+1:100;]]]
