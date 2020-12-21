// Task 2ii

db.movies_metadata.aggregate([
    // TODO: Write your query here
    {
    	$project: {
    		_id: 0,
    		tagline: {$split: [{$toLower: "$tagline"}, " "]}
    	}
    },

    {$unwind: "$tagline"},

    {
    	$project: {
    		_id: 0,
    		tagline: {$trim: {input: "$tagline", chars: " ,!.?"}},
    		len: {$strLenCP: "$tagline"}
    	}
    },

    {
    	$match: {
    		len: {
    			$gt: 3
    		}
    	}
    },

    {
    	$group: {
    		_id: "$tagline",
    		count: {$sum: 1}
    	}
    },

    {
    	$sort: {
    		count: -1
    	}
    },

    {
    	$limit: 20
    },

    {
    	$project: {
    		_id: 1,
    		count: 1
    	}
    }


]);