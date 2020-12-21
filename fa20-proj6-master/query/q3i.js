// Task 3i

db.credits.aggregate([
    // TODO: Write your query here
    //{$unwind: "$cast"},

	{$unwind: "$cast"},
    {$project: {
    	_id: "$movieId",
    	character: "$cast.character",
    	cast: "$cast.id"
    }},

    {
    	$match: {
    		cast: 7624
    	}
    },

    {
    	$lookup: {
    		from: "movies_metadata", // Search inside movies_metadata
            localField: "_id", // match our _id
            foreignField: "movieId", // with the "movieId" in movies_metadata
            as: "movies"
    	}
    },

    {$unwind: "$movies"},

    {
    	$project: {
    		_id: 0,
    		title: "$movies.title",
    		release_date: "$movies.release_date",
    		character: "$character"
    	}
    },

    {$sort: {
    	release_date: -1
    }}
]);