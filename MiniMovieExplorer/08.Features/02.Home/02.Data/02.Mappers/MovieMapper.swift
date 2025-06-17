import Foundation

#warning("Mapp this to a separate file")
enum MovieMapper {
    static func map(_ entity: MovieEntity) -> Movie {
        return Movie(
            id: entity.id ?? .defaultValue,
            title: entity.title ?? .defaultValue,
            overview: entity.overview ?? .defaultValue,
            posterPath: entity.posterPath ?? .defaultValue,
            backdropPath: entity.backdropPath ?? .defaultValue,
            releaseDate: entity.releaseDate ?? .defaultValue,
            voteAverage: entity.voteAverage ?? .defaultValue,
            voteCount: entity.voteCount ?? .defaultValue
        )
    }
    
    static func map(_ entities: [MovieEntity]) -> [Movie] {
        return entities.map { map($0) }
    }
    
    static func map(_ entity: MovieDetailsEntity) -> MovieDetails {
        return MovieDetails(
            movie: Movie(
                id: entity.id ?? .defaultValue,
                title: entity.title ?? .defaultValue,
                overview: entity.overview ?? .defaultValue,
                posterPath: entity.posterPath ?? .defaultValue,
                backdropPath: entity.backdropPath ?? .defaultValue,
                releaseDate: entity.releaseDate ?? .defaultValue,
                voteAverage: entity.voteAverage ?? .defaultValue,
                voteCount: entity.voteCount ?? .defaultValue
            ),
            runtime: entity.runtime ?? .defaultValue,
//            genres: entity.genres.map { map($0) } ?? .defaultValue,
//            productionCompanies: entity.productionCompanies.map { map($0) },
//            spokenLanguages: entity.spokenLanguages.map { map($0) },
            genres: [],
            productionCompanies: [],
            spokenLanguages: [],
            budget: entity.budget ?? .defaultValue,
            revenue: entity.revenue ?? .defaultValue,
            tagline: entity.tagline ?? .defaultValue,
            status: entity.status ?? .defaultValue,
            homepage: entity.homepage ?? .defaultValue
        )
    }
    
    private static func map(_ entity: GenreEntity) -> Genre {
        return Genre(
            id: entity.id ?? .defaultValue,
            name: entity.name ?? .defaultValue
        )
    }
    
    private static func map(_ entity: ProductionCompanyEntity) -> ProductionCompany {
        return ProductionCompany(
            id: entity.id ?? .defaultValue,
            name: entity.name ?? .defaultValue,
            logoPath: entity.logoPath ?? .defaultValue,
            originCountry: entity.originCountry ?? .defaultValue
        )
    }
    
    private static func map(_ entity: LanguageEntity) -> Language {
        return Language(
            englishName: entity.englishName ?? .defaultValue,
            iso6391: entity.iso6391 ?? .defaultValue
        )
    }
} 
