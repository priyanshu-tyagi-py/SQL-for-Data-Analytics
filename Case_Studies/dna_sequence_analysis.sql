-- DNA Sequence Analysis

-- Problem Statement:
-- Given a table 'Samples' containing DNA sequences,
-- identify important biological patterns in each sequence:
-- 1. Whether the sequence starts with a start codon (ATG)
-- 2. Whether the sequence ends with a stop codon (TAA, TAG, TGA)
-- 3. Whether the sequence contains repeating pattern 'ATAT'
-- 4. Whether the sequence contains repeating pattern 'GGG'

-- Approach:
-- - Used SQL CASE statements to create binary flags (1/0)
-- - Used LIKE operator for pattern matching:
--     • 'ATG%' → checks start codon
--     • '%TAA', '%TAG', '%TGA' → checks stop codons at end
--     • '%ATAT%' → checks repeating ATAT pattern
--     • '%GGG%' → checks GGG pattern
-- - Transformed raw DNA data into meaningful analytical features

SELECT 
    sample_id, 
    dna_sequence, 
    species,

    CASE 
        WHEN dna_sequence LIKE 'ATG%' THEN 1 
        ELSE 0
    END AS has_start,

    CASE 
        WHEN dna_sequence REGEXP 'TAA$|TAG$|TGA$'  THEN 1
        ELSE 0
    END AS has_stop,
  
    CASE 
        WHEN dna_sequence LIKE '%ATAT%' THEN 1 
        ELSE 0
    END AS has_atat,

    CASE 
        WHEN dna_sequence LIKE '%GGG%' THEN 1 
        ELSE 0
    END AS has_ggg

FROM Samples
ORDER BY sample_id ASC;

-- Insights:
-- - Identifies valid protein-coding DNA sequences
-- - Helps detect mutation/repeat patterns (ATAT, GGG)
-- - Can be used for feature engineering in ML models
